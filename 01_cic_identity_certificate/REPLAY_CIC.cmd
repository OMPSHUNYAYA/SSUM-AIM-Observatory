@echo off
echo SSUM-AIM Observatory REPLAY - CIC
echo ---------------------------------

REM First run
python cic_demo.py > OUT_A.txt

REM Second run (independent replay)
python cic_demo.py > OUT_B.txt

REM Compare byte identity
fc /b OUT_A.txt OUT_B.txt > nul

if errorlevel 1 (
    echo.
    echo STATUS: FAIL
    echo REASON: REPLAY_MISMATCH
    exit /b 1
)

echo.
echo STATUS: PASS
echo REASON: REPLAY_IDENTITY_CONFIRMED (B_A = B_B)

echo.
echo Replay certification complete.