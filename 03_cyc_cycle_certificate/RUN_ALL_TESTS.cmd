@echo off
setlocal enabledelayedexpansion

call RUN_CYC.cmd
if errorlevel 1 exit /b 1

call REPLAY_CYC.cmd
if errorlevel 1 exit /b 1

call VERIFY_CYC.cmd
exit /b %errorlevel%