@echo off
setlocal
cd /d "%~dp0"

python erc_demo.py > OUT_A.txt
python erc_demo.py > OUT_B.txt

fc /b OUT_A.txt OUT_B.txt > nul

if errorlevel 1 (
    echo STATUS: FAIL
    echo REASON: REPLAY_IDENTITY_BROKEN
    exit /b 1
) else (
    echo STATUS: PASS
    echo REASON: REPLAY_IDENTITY_CONFIRMED (B_A = B_B)
)

endlocal