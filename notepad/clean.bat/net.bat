@echo off
echo.
ipconfig /flushdns
pause
 
del "%tmp%\*.*" /s /q /f
 
FOR /d %%p IN ("%tmp%\*.*") DO rmdir "%%p" /s /q
pause
reboot