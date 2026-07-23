@echo off
setlocal EnableExtensions EnableDelayedExpansion
title PokeScape Direct RuneLite Launcher - Debug

echo.
echo ========================================
echo PokeScape Direct RuneLite Launcher DEBUG
echo ========================================
echo.

rem This starts RuneLite's actual client directly in developer mode.
rem The normal RuneLite.exe/Jagex Launcher route can pass --developer-mode
rem in the text args but still not enable sideloaded private plugins.

set "HERE=%~dp0"
set "PLUGIN_JAR=%HERE%pokescape.jar"
set "RL_HOME=%USERPROFILE%\.runelite"
set "SIDELOAD_DIR=%RL_HOME%\sideloaded-plugins"
set "SIDELOAD_JAR=%SIDELOAD_DIR%\pokescape.jar"
set "REPO=%RL_HOME%\repository2"
set "JAVA=%LOCALAPPDATA%\RuneLite\jre\bin\java.exe"
set "PREFERRED_VERSION=1.12.33"

if not exist "%PLUGIN_JAR%" (
  echo ERROR: Could not find pokescape.jar next to this .bat file.
  echo.
  echo Keep these two files in the same folder:
  echo   Launch PokeScape RuneLite.bat
  echo   pokescape.jar
  echo.
  pause
  exit /b 1
)

if not exist "%JAVA%" (
  echo ERROR: Could not find RuneLite's Java runtime here:
  echo "%JAVA%"
  echo.
  echo Install or update normal RuneLite from https://runelite.net/
  echo Open normal RuneLite once, let it update, close it, then try again.
  echo.
  pause
  exit /b 1
)

if not exist "%REPO%" (
  echo ERROR: Could not find RuneLite's library cache here:
  echo "%REPO%"
  echo.
  echo Open normal RuneLite once, let it update, close it, then try again.
  echo.
  pause
  exit /b 1
)

if not exist "%SIDELOAD_DIR%" (
  echo Creating sideload folder...
  mkdir "%SIDELOAD_DIR%"
)

echo Copying PokeScape plugin into RuneLite...
copy /Y "%PLUGIN_JAR%" "%SIDELOAD_JAR%" >nul
if errorlevel 1 (
  if exist "%SIDELOAD_JAR%" (
    echo PokeScape jar is currently locked by RuneLite.
    echo Using the existing sideloaded copy.
  ) else (
    echo ERROR: Could not copy pokescape.jar into RuneLite.
    echo Close all RuneLite windows and run this .bat again.
    echo.
    echo From:
    echo "%PLUGIN_JAR%"
    echo.
    echo To:
    echo "%SIDELOAD_JAR%"
    echo.
    pause
    exit /b 1
  )
)

if not exist "%RL_HOME%\credentials.properties" (
  echo.
  echo WARNING FOR JAGEX ACCOUNT USERS
  echo No credentials.properties was found here:
  echo "%RL_HOME%\credentials.properties"
  echo.
  echo If login fails, open normal RuneLite through the Jagex Launcher once.
  echo.
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
  echo ERROR: Could not find client-*.jar in:
  echo "%REPO%"
  echo.
  echo Open normal RuneLite once, let it update, close it, then try again.
  echo.
  pause
  exit /b 1
)

if not defined INJECTED_JAR (
  echo ERROR: Could not find injected-client-*.jar in:
  echo "%REPO%"
  echo.
  echo Open normal RuneLite once, let it update, close it, then try again.
  echo.
  pause
  exit /b 1
)

set "CP=%CLIENT_JAR%;%INJECTED_JAR%"
for %%J in ("%REPO%\*.jar") do (
  if /I not "%%~fJ"=="%CLIENT_JAR%" if /I not "%%~fJ"=="%INJECTED_JAR%" set "CP=!CP!;%%~fJ"
)

echo.
echo Java:
echo "%JAVA%"
echo.
echo Client:
echo "%CLIENT_JAR%"
echo.
echo Injected client:
echo "%INJECTED_JAR%"
echo.
echo Sideloaded plugin:
echo "%SIDELOAD_JAR%"
echo.
echo Launching direct RuneLite client in developer mode...
echo.

"%JAVA%" -ea -cp "%CP%" net.runelite.client.RuneLite --developer-mode

echo.
echo RuneLite exited with code %ERRORLEVEL%.
echo If PokeScape did not appear, send Jay this whole black-window text.
echo.
pause
exit /b %ERRORLEVEL%
