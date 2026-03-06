@echo off
setlocal
cd /d "%~dp0"

powershell -NoProfile -Command ^
 "$lines = Get-Content ERC_MANIFEST.sha256; $ok = $true; foreach ($line in $lines) { if ($line.Trim() -eq '') { continue }; $parts = $line -split ' \*', 2; $expected = $parts[0].Trim().ToLower(); $file = $parts[1].Trim(); if (!(Test-Path $file)) { $ok = $false; Write-Output ('MISSING: ' + $file); continue }; $actual = (Get-FileHash $file -Algorithm SHA256).Hash.ToLower(); if ($actual -ne $expected) { $ok = $false; Write-Output ('MISMATCH: ' + $file) } }; if ($ok) { Write-Output 'STATUS: PASS'; Write-Output 'REASON: MANIFEST_MATCHED'; exit 0 } else { Write-Output 'STATUS: FAIL'; Write-Output 'REASON: MANIFEST_MISMATCH'; exit 1 }"

endlocal