@echo off
setlocal enabledelayedexpansion

if not exist outputs mkdir outputs

python cyc_demo.py > outputs\OUT_PRIMARY.txt
copy /y outputs\OUT_PRIMARY.txt OUT_PRIMARY.txt > nul

type outputs\OUT_PRIMARY.txt
echo.
echo DONE