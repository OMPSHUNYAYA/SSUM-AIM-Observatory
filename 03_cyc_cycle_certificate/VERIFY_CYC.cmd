@echo off
setlocal enabledelayedexpansion

if not exist OUT_PRIMARY.txt (
  echo MISSING OUT_PRIMARY.txt
  exit /b 1
)

if not exist OUT_A.txt (
  echo MISSING OUT_A.txt
  exit /b 1
)

if not exist OUT_B.txt (
  echo MISSING OUT_B.txt
  exit /b 1
)

for %%F in (OUT_PRIMARY.txt OUT_A.txt OUT_B.txt) do (
  for %%S in ("%%F") do echo %%F size=%%~zS bytes
)

fc /b OUT_PRIMARY.txt OUT_A.txt > nul
if errorlevel 1 (
  echo FAIL: OUT_PRIMARY.txt and OUT_A.txt differ
  exit /b 2
)

fc /b OUT_A.txt OUT_B.txt > nul
if errorlevel 1 (
  echo FAIL: OUT_A.txt and OUT_B.txt differ
  exit /b 3
)

echo PASS: byte-identical replay verified
exit /b 0