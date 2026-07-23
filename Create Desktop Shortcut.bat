@echo off
setlocal EnableExtensions

title PokeScape Shortcut Creator

set "HERE=%~dp0"
set "LAUNCHER=%HERE%Launch PokeScape RuneLite.bat"
set "ICON=%HERE%PokeScape-PS.ico"

if not exist "%LAUNCHER%" (
    echo.
    echo ERROR: Could not find:
    echo "%LAUNCHER%"
    echo.
    echo Keep this shortcut creator in the same folder as
    echo Launch PokeScape RuneLite.bat
    echo.
    pause
    exit /b 1
)

set "POKESCAPE_HERE=%HERE%"
set "POKESCAPE_LAUNCHER=%LAUNCHER%"
set "POKESCAPE_ICON=%ICON%"
set "PS1=%TEMP%\PokeScape_Create_Shortcut_%RANDOM%_%RANDOM%.ps1"

> "%PS1%" echo Add-Type -AssemblyName System.Windows.Forms
>>"%PS1%" echo $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
>>"%PS1%" echo $dialog.Description = 'Choose the folder where you want the PokeScape shortcut to be created.'
>>"%PS1%" echo $dialog.ShowNewFolderButton = $true
>>"%PS1%" echo $desktop = [Environment]::GetFolderPath('Desktop')
>>"%PS1%" echo if ($desktop) { $dialog.SelectedPath = $desktop }
>>"%PS1%" echo if ($dialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) { exit 2 }
>>"%PS1%" echo try {
>>"%PS1%" echo     $launcher = $env:POKESCAPE_LAUNCHER
>>"%PS1%" echo     $workingDirectory = $env:POKESCAPE_HERE
>>"%PS1%" echo     $icon = $env:POKESCAPE_ICON
>>"%PS1%" echo     $shortcutPath = Join-Path $dialog.SelectedPath 'PokeScape.lnk'
>>"%PS1%" echo     if (-not (Test-Path -LiteralPath $launcher)) { throw 'The PokeScape launcher could not be found.' }
>>"%PS1%" echo     $shell = New-Object -ComObject WScript.Shell
>>"%PS1%" echo     if (Test-Path -LiteralPath $shortcutPath) { Remove-Item -LiteralPath $shortcutPath -Force }
>>"%PS1%" echo     $shortcut = $shell.CreateShortcut($shortcutPath)
>>"%PS1%" echo     $shortcut.TargetPath = $launcher
>>"%PS1%" echo     $shortcut.WorkingDirectory = $workingDirectory
>>"%PS1%" echo     $shortcut.Description = 'Launch PokeScape RuneLite'
>>"%PS1%" echo     $shortcut.WindowStyle = 1
>>"%PS1%" echo     if (Test-Path -LiteralPath $icon) { $shortcut.IconLocation = $icon + ',0' }
>>"%PS1%" echo     $shortcut.Save()
>>"%PS1%" echo     [System.Windows.Forms.MessageBox]::Show("PokeScape shortcut created here:`n`n$shortcutPath", 'PokeScape', 'OK', 'Information') ^| Out-Null
>>"%PS1%" echo     exit 0
>>"%PS1%" echo }
>>"%PS1%" echo catch {
>>"%PS1%" echo     [System.Windows.Forms.MessageBox]::Show("The shortcut could not be created:`n`n$($_.Exception.Message)", 'PokeScape', 'OK', 'Error') ^| Out-Null
>>"%PS1%" echo     exit 1
>>"%PS1%" echo }

powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -File "%PS1%"
set "RESULT=%ERRORLEVEL%"
del /q "%PS1%" >nul 2>&1

if "%RESULT%"=="0" exit /b 0
if "%RESULT%"=="2" (
    echo.
    echo Shortcut creation was cancelled.
    timeout /t 2 /nobreak >nul
    exit /b 2
)

echo.
echo The shortcut could not be created.
echo Try choosing a folder you have permission to write to, such as Desktop.
echo.
pause
exit /b 1
