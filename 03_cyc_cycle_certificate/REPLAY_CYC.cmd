@echo off
setlocal enabledelayedexpansion

if not exist outputs mkdir outputs

echo.
echo ============================
echo REPLAY RUN A
echo ============================
python cyc_demo.py > outputs\OUT_A.txt
copy /y outputs\OUT_A.txt OUT_A.txt > nul
type outputs\OUT_A.txt

echo.
echo ============================
echo REPLAY RUN B
echo ============================
python cyc_demo.py > outputs\OUT_B.txt
copy /y outputs\OUT_B.txt OUT_B.txt > nul
type outputs\OUT_B.txt

echo.
echo Replay complete.
echo outputs\OUT_A.txt written
echo outputs\OUT_B.txt written