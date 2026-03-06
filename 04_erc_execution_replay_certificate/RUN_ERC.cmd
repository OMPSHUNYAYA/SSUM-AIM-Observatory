@echo off
setlocal
cd /d "%~dp0"
python erc_demo.py > OUT_PRIMARY.txt
type OUT_PRIMARY.txt
endlocal