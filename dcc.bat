@echo off
title Day Client Cleanup - github.com/cubiclemonkey/dayz-client-cleanup
color 6
echo ## %date% > %userprofile%\dayz-client-cleanup.log
echo       __
echo   ___/ /_______
echo  / _  / __/ __/
echo  \_,_/\__/\__/ 
echo.
REM ### Dumps a directory list of files prior to deletion
echo # Directory Before Deletion >> %userprofile%\dayz-client-cleanup.log
dir %localappdata%\DayZ /a:-D /b >> %userprofile%\dayz-client-cleanup.log
echo.  >> %userprofile%\dayz-client-cleanup.log
echo # Directory Size Before Deletion >> %userprofile%\dayz-client-cleanup.log
Powershell.exe "'{0} MB' -f ((Get-ChildItem %localappdata%\DayZ -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)" >> %userprofile%\dayz-client-cleanup.log
echo.  >> %userprofile%\dayz-client-cleanup.log

REM ### Interface prompts
echo  # You're about to delete log files from: %localappdata%\DayZ
echo.
echo  Current folder size: %localappdata%\DayZ
echo.
Powershell.exe "'{0} MB' -f ((Get-ChildItem %localappdata%\DayZ -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)"
echo.
echo  # Logs of this script are kept in: %userprofile%\dayz-client-cleanup.log
echo.
PAUSE
echo Will begin in . . .
timeout 5

REM ### Deletes log, rpt, and mdmp files older than two days
forfiles -p "%localappdata%\DayZ" -s -m *.log -d -2 -c "cmd /c del @path"
forfiles -p "%localappdata%\DayZ" -s -m *.rpt -d -2 -c "cmd /c del @path"
forfiles -p "%localappdata%\DayZ" -s -m *.mdmp -d -2 -c "cmd /c del @path"

REM ### Dumps a directory list of files after to deletion
echo # Directory After Deletion >> %userprofile%\dayz-client-cleanup.log
dir %localappdata%\DayZ /a:-D /b >> %userprofile%\dayz-client-cleanup.log
echo.  >> %userprofile%\dayz-client-cleanup.log
echo # Directory Size After Deletion >> %userprofile%\dayz-client-cleanup.log
Powershell.exe "'{0} MB' -f ((Get-ChildItem %localappdata%\DayZ -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)" >> %userprofile%\dayz-client-cleanup.log

REM ### Post run prompts
set /p openlogfile= Do you want to read the log file? (y, N): 
IF /I %openlogfile%==y start notepad %userprofile%\dayz-client-cleanup.log