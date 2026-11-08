@echo off
setlocal
wsl.exe --cd "%~dp0" bash -lc "./run-workers.sh"
exit /b %ERRORLEVEL%