@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "HERE=%~dp0"
set "LOG=%HERE%PokeScape Launcher Last Run.log"
set "CONFIG=%HERE%PokeScape RuneLite Location.txt"
set "PLUGIN_JAR=%HERE%pokescape.jar"
set "RL_HOME=%USERPROFILE%\.runelite"
set "SIDELOAD_DIR=%RL_HOME%\sideloaded-plugins"
set "SIDELOAD_JAR=%SIDELOAD_DIR%\pokescape.jar"
set "REPO=%RL_HOME%\repository2"
set "PREFERRED_VERSION=1.12.33"
set "JAVA="
set "RL_INSTALL="

> "%LOG%" echo PokeScape launcher started %DATE% %TIME%

if not exist "%PLUGIN_JAR%" (
  >> "%LOG%" echo ERROR: Could not find pokescape.jar next to the launcher.
  echo.
  echo ERROR: Could not find pokescape.jar next to this launcher.
  echo Keep the BAT file and pokescape.jar in the same folder.
  pause
  exit /b 1
)

rem First try RuneLite's normal Windows installation folder.
call :FindJava "%LOCALAPPDATA%\RuneLite"

rem If that fails, try the folder selected on a previous launch.
if not defined JAVA if exist "%CONFIG%" (
  set /p "RL_INSTALL="<"%CONFIG%"
  if defined RL_INSTALL call :FindJava "!RL_INSTALL!"
)

rem If RuneLite is installed elsewhere, let the user browse to it.
:ChooseRuneLiteFolder
if not defined JAVA (
  echo.
  echo RuneLite was not found in its usual location.
  echo Select the RuneLite installation folder in the window that opens.
  echo It normally contains RuneLite.exe and a folder named jre.
  echo.

  call :PickRuneLiteFolder

  if not defined RL_INSTALL (
    >> "%LOG%" echo ERROR: RuneLite folder selection was cancelled.
    echo.
    echo RuneLite folder selection was cancelled.
    pause
    exit /b 1
  )

  call :FindJava "!RL_INSTALL!"

  if not defined JAVA (
    >> "%LOG%" echo ERROR: No RuneLite Java runtime was found under "!RL_INSTALL!"
    echo.
    echo That folder does not appear to contain RuneLite's Java runtime.
    echo Select the main RuneLite folder, usually the one containing RuneLite.exe and the jre folder.
    echo.
    pause
    set "RL_INSTALL="
    goto ChooseRuneLiteFolder
  )

  rem Remember the chosen folder so the browser is not shown every time.
  > "%CONFIG%" <nul set /p "=!RL_INSTALL!"
)

if not defined JAVA (
  >> "%LOG%" echo ERROR: Could not find RuneLite Java.
  echo.
  echo ERROR: Could not find RuneLite's Java runtime.
  pause
  exit /b 1
)

if not exist "%REPO%" (
  >> "%LOG%" echo ERROR: Could not find RuneLite repository cache: "%REPO%"
  echo.
  echo ERROR: Could not find RuneLite's repository cache:
  echo "%REPO%"
  echo.
  echo Open normal RuneLite once, let it fully update, close it, then try again.
  pause
  exit /b 1
)

if not exist "%SIDELOAD_DIR%" (
  mkdir "%SIDELOAD_DIR%" >> "%LOG%" 2>&1
)

copy /Y "%PLUGIN_JAR%" "%SIDELOAD_JAR%" >> "%LOG%" 2>&1
if errorlevel 1 (
  if exist "%SIDELOAD_JAR%" (
    >> "%LOG%" echo PokeScape jar is locked by RuneLite. Using existing sideloaded copy.
  ) else (
    >> "%LOG%" echo ERROR: Could not copy pokescape.jar into RuneLite.
    echo.
    echo ERROR: Could not copy pokescape.jar into RuneLite.
    echo Close RuneLite and try again.
    pause
    exit /b 1
  )
)

set "CLIENT_JAR="
set "INJECTED_JAR="

if exist "%REPO%\client-%PREFERRED_VERSION%.jar" set "CLIENT_JAR=%REPO%\client-%PREFERRED_VERSION%.jar"
if exist "%REPO%\injected-client-%PREFERRED_VERSION%.jar" set "INJECTED_JAR=%REPO%\injected-client-%PREFERRED_VERSION%.jar"

if not defined CLIENT_JAR (
  for /f "delims=" %%I in ('dir /b /a-d /o-d "%REPO%\client-*.jar" 2^>nul') do (
    if not defined CLIENT_JAR set "CLIENT_JAR=%REPO%\%%I"
  )
)

if not defined INJECTED_JAR (
  for /f "delims=" %%I in ('dir /b /a-d /o-d "%REPO%\injected-client-*.jar" 2^>nul') do (
    if not defined INJECTED_JAR set "INJECTED_JAR=%REPO%\%%I"
  )
)

if not defined CLIENT_JAR (
  >> "%LOG%" echo ERROR: Could not find client-*.jar in "%REPO%"
  echo.
  echo ERROR: Could not find RuneLite client files.
  echo Open normal RuneLite once, let it update, close it, then try again.
  pause
  exit /b 1
)

if not defined INJECTED_JAR (
  >> "%LOG%" echo ERROR: Could not find injected-client-*.jar in "%REPO%"
  echo.
  echo ERROR: Could not find RuneLite injected-client files.
  echo Open normal RuneLite once, let it update, close it, then try again.
  pause
  exit /b 1
)

set "CP=%CLIENT_JAR%;%INJECTED_JAR%"
for %%J in ("%REPO%\*.jar") do (
  if /I not "%%~fJ"=="%CLIENT_JAR%" if /I not "%%~fJ"=="%INJECTED_JAR%" set "CP=!CP!;%%~fJ"
)

>> "%LOG%" echo RuneLite folder: "%RL_INSTALL%"
>> "%LOG%" echo Java: "%JAVA%"
>> "%LOG%" echo Client: "%CLIENT_JAR%"
>> "%LOG%" echo Injected client: "%INJECTED_JAR%"
>> "%LOG%" echo Sideloaded plugin: "%SIDELOAD_JAR%"
>> "%LOG%" echo Launching RuneLite in developer mode.

start "PokeScape RuneLite" "%JAVA%" -ea -cp "%CP%" net.runelite.client.RuneLite --developer-mode
exit /b 0

:FindJava
set "CANDIDATE=%~1"
if not defined CANDIDATE exit /b 0

rem Main RuneLite installation folder selected.
if exist "%CANDIDATE%\jre\bin\javaw.exe" (
  set "RL_INSTALL=%CANDIDATE%"
  set "JAVA=%CANDIDATE%\jre\bin\javaw.exe"
  exit /b 0
)

rem Also accept the jre folder itself.
if exist "%CANDIDATE%\bin\javaw.exe" (
  for %%I in ("%CANDIDATE%\..") do set "RL_INSTALL=%%~fI"
  set "JAVA=%CANDIDATE%\bin\javaw.exe"
  exit /b 0
)

rem Also accept the bin folder itself.
if exist "%CANDIDATE%\javaw.exe" (
  for %%I in ("%CANDIDATE%\..\..") do set "RL_INSTALL=%%~fI"
  set "JAVA=%CANDIDATE%\javaw.exe"
  exit /b 0
)

exit /b 0

:PickRuneLiteFolder
set "RL_INSTALL="
set "PICKER_PS1=%TEMP%\PokeScape_Select_RuneLite_%RANDOM%_%RANDOM%.ps1"
set "PICKER_RESULT=%TEMP%\PokeScape_Select_RuneLite_%RANDOM%_%RANDOM%.txt"

> "%PICKER_PS1%" (
  echo Add-Type -AssemblyName System.Windows.Forms
  echo $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
  echo $dialog.Description = 'Select the RuneLite installation folder. It usually contains RuneLite.exe and a jre folder.'
  echo $dialog.ShowNewFolderButton = $false
  echo if ^($dialog.ShowDialog^(^) -eq [System.Windows.Forms.DialogResult]::OK^) {
  echo     [Console]::Write^($dialog.SelectedPath^)
  echo }
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -File "%PICKER_PS1%" > "%PICKER_RESULT%" 2>> "%LOG%"
if exist "%PICKER_RESULT%" set /p "RL_INSTALL="<"%PICKER_RESULT%"

del /q "%PICKER_PS1%" >nul 2>&1
del /q "%PICKER_RESULT%" >nul 2>&1
exit /b 0
