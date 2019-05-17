@echo off
echo.
del "%tmp%\*.*" /s /q /f
FOR /d %%p IN ("%tmp%\*.*") DO rmdir "%%p" /s /q
pause
REM echo.
REM ipconfig /flushdns
REM pause