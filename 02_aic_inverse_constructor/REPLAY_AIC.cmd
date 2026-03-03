@echo off
setlocal EnableDelayedExpansion

python aic_demo.py > OUT_A.txt 2> ERR_A.txt
if errorlevel 1 goto FAIL_RUN_A

python aic_demo.py > OUT_B.txt 2> ERR_B.txt
if errorlevel 1 goto FAIL_RUN_B

set "HA="
set "HB="

for /f "skip=1 tokens=1" %%H in ('certutil -hashfile OUT_A.txt SHA256') do (
  if not defined HA set "HA=%%H"
)

for /f "skip=1 tokens=1" %%H in ('certutil -hashfile OUT_B.txt SHA256') do (
  if not defined HB set "HB=%%H"
)

if not defined HA goto FAIL_HASH_A
if not defined HB goto FAIL_HASH_B

echo OUT_A_SHA256=!HA!
echo OUT_B_SHA256=!HB!

if /i "!HA!"=="!HB!" goto PASS
goto FAIL_MISMATCH

:PASS
echo STATUS: PASS
echo REASON: REPLAY_IDENTITY_CONFIRMED (B_A = B_B)
echo Output SHA256: !HA!
echo Replay certification complete.
exit /b 0

:FAIL_RUN_A
echo STATUS: FAIL
echo REASON: RUN_A_FAILED
exit /b 1

:FAIL_RUN_B
echo STATUS: FAIL
echo REASON: RUN_B_FAILED
exit /b 1

:FAIL_HASH_A
echo STATUS: FAIL
echo REASON: HASH_READ_FAILED_OUT_A
exit /b 1

:FAIL_HASH_B
echo STATUS: FAIL
echo REASON: HASH_READ_FAILED_OUT_B
exit /b 1

:FAIL_MISMATCH
echo STATUS: FAIL
echo REASON: REPLAY_IDENTITY_FAILED (B_A != B_B)
exit /b 1