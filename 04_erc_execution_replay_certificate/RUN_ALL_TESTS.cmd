@echo off
setlocal
cd /d "%~dp0"

call RUN_ERC.cmd
call VERIFY_ERC.cmd
call REPLAY_ERC.cmd

endlocal