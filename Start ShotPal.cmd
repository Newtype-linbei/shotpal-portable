@echo off
setlocal
cd /d "%~dp0"
where py >nul 2>nul
if not errorlevel 1 (
  py -3 scripts\start_portable.py %*
) else (
  python scripts\start_portable.py %*
)
if errorlevel 1 (
  echo ShotPal could not start. Python 3.10+ is required. See README.md.
  pause
)
