@echo off
setlocal enabledelayedexpansion

echo SSUM-AIM Observatory VERIFY - CIC
echo ---------------------------------
echo.

REM 1) Run demo and capture output
python cic_demo.py > OUT_PRIMARY.txt

REM 2) Extract SHA256 of script (robust parsing: remove non-hash lines)
set H_SCRIPT=
for /f "tokens=1" %%a in ('
  certutil -hashfile cic_demo.py SHA256 ^| findstr /v /i "hash certutil"
') do (
  set H_SCRIPT=%%a
  goto :got_script
)
:got_script

REM 3) Extract SHA256 of output file
set H_OUT=
for /f "tokens=1" %%a in ('
  certutil -hashfile OUT_PRIMARY.txt SHA256 ^| findstr /v /i "hash certutil"
') do (
  set H_OUT=%%a
  goto :got_out
)
:got_out

if not defined H_SCRIPT (
  echo STATUS: FAIL
  echo REASON: COULD_NOT_PARSE_SCRIPT_HASH
  exit /b 10
)

if not defined H_OUT (
  echo STATUS: FAIL
  echo REASON: COULD_NOT_PARSE_OUTPUT_HASH
  exit /b 11
)

echo Script SHA256: !H_SCRIPT!
echo Output SHA256: !H_OUT!
echo.

REM 4) Compare script hash against frozen manifest
findstr /i "!H_SCRIPT!  cic_demo.py" CIC_MANIFEST.sha256 >nul
if errorlevel 1 (
  findstr /i "!H_SCRIPT! cic_demo.py" CIC_MANIFEST.sha256 >nul
  if errorlevel 1 (
    echo STATUS: FAIL
    echo REASON: SCRIPT_HASH_MISMATCH (manifest does not match)
    exit /b 2
  )
)

echo STATUS: PASS
echo REASON: MANIFEST_MATCHED
echo.
echo CIC verification complete.
exit /b 0
