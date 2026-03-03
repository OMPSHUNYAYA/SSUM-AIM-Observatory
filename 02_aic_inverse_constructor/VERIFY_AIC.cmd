@echo off
setlocal EnableDelayedExpansion

python aic_demo.py > OUT_PRIMARY.txt
if errorlevel 1 (
  echo STATUS: FAIL
  echo REASON: EXECUTION_FAILED
  exit /b 1
)

set "H1="
set "H2="
set "H3="

for /f "skip=1 tokens=1" %%H in ('certutil -hashfile aic_core.py SHA256') do (
  if not defined H1 set "H1=%%H"
)

for /f "skip=1 tokens=1" %%H in ('certutil -hashfile aic_demo.py SHA256') do (
  if not defined H2 set "H2=%%H"
)

for /f "skip=1 tokens=1" %%H in ('certutil -hashfile OUT_PRIMARY.txt SHA256') do (
  if not defined H3 set "H3=%%H"
)

if not defined H1 (
  echo STATUS: FAIL
  echo REASON: HASH_READ_FAILED_AIC_CORE
  exit /b 1
)

if not defined H2 (
  echo STATUS: FAIL
  echo REASON: HASH_READ_FAILED_AIC_DEMO
  exit /b 1
)

if not defined H3 (
  echo STATUS: FAIL
  echo REASON: HASH_READ_FAILED_OUT_PRIMARY
  exit /b 1
)

if not exist AIC_MANIFEST.sha256 goto WRITE_MANIFEST

set "M1="
set "M2="
set "M3="

for /f "tokens=1,2" %%a in (AIC_MANIFEST.sha256) do (
  if /i "%%b"=="aic_core.py" set "M1=%%a"
  if /i "%%b"=="aic_demo.py" set "M2=%%a"
  if /i "%%b"=="OUT_PRIMARY.txt" set "M3=%%a"
)

if not defined M1 goto FAIL_MANIFEST_FORMAT
if not defined M2 goto FAIL_MANIFEST_FORMAT
if not defined M3 goto FAIL_MANIFEST_FORMAT

if /i not "!M1!"=="!H1!" goto FAIL_MISMATCH
if /i not "!M2!"=="!H2!" goto FAIL_MISMATCH
if /i not "!M3!"=="!H3!" goto FAIL_MISMATCH

echo STATUS: PASS
echo REASON: MANIFEST_MATCHED
exit /b 0

:WRITE_MANIFEST
echo !H1!  aic_core.py> AIC_MANIFEST.sha256
echo !H2!  aic_demo.py>> AIC_MANIFEST.sha256
echo !H3!  OUT_PRIMARY.txt>> AIC_MANIFEST.sha256
echo STATUS: PASS
echo REASON: MANIFEST_WRITTEN
exit /b 0

:FAIL_MISMATCH
echo STATUS: FAIL
echo REASON: MANIFEST_MISMATCH
echo aic_core.py_EXPECTED=!M1!
echo aic_core.py_ACTUAL=!H1!
echo aic_demo.py_EXPECTED=!M2!
echo aic_demo.py_ACTUAL=!H2!
echo OUT_PRIMARY.txt_EXPECTED=!M3!
echo OUT_PRIMARY.txt_ACTUAL=!H3!
exit /b 1

:FAIL_MANIFEST_FORMAT
echo STATUS: FAIL
echo REASON: MANIFEST_FORMAT_INVALID
exit /b 1