@echo off
setlocal
title Reset PokeScape Save

echo.
echo ==========================
echo Reset PokeScape Save
echo ==========================
echo.
echo This will remove only PokeScape saved data from RuneLite profiles.
echo It will NOT delete your RuneLite account, plugins, or Jagex credentials.
echo.
echo Close RuneLite before continuing.
echo.
pause

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$profiles=Join-Path $env:USERPROFILE '.runelite\profiles2';" ^
  "if (!(Test-Path $profiles)) { Write-Host 'No RuneLite profiles2 folder found.'; exit 0 }" ^
  "$stamp=Get-Date -Format 'yyyyMMdd-HHmmss';" ^
  "$files=Get-ChildItem -LiteralPath $profiles -Filter '*.properties' -File;" ^
  "$changed=0;" ^
  "foreach ($file in $files) {" ^
  "  $lines=Get-Content -LiteralPath $file.FullName;" ^
  "  $kept=$lines | Where-Object { $_ -notmatch '^pokescape\.' };" ^
  "  if ($kept.Count -ne $lines.Count) {" ^
  "    Copy-Item -LiteralPath $file.FullName -Destination ($file.FullName + '.pokescape-reset-backup-' + $stamp) -Force;" ^
  "    Set-Content -LiteralPath $file.FullName -Value $kept -Encoding UTF8;" ^
  "    Write-Host ('Reset PokeScape data in: ' + $file.FullName);" ^
  "    $changed++;" ^
  "  }" ^
  "}" ^
  "if ($changed -eq 0) { Write-Host 'No PokeScape save data was found.' } else { Write-Host ('Done. Profiles changed: ' + $changed) }"

echo.
echo Reset finished.
echo Now launch PokeScape again with:
echo Launch PokeScape RuneLite.bat
echo.
pause
