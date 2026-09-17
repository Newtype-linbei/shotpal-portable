@echo off
setlocal
cd /d "%~dp0"
where py >nul 2>nul
if not errorlevel 1 (
  py -3.11 scripts\setup_windows.py %*
) else (
  python scripts\setup_windows.py %*
)
if errorlevel 1 (
  echo Setup failed. Install 64-bit Python 3.11 and read the reported log.
  pause
  exit /b 1
)
echo Setup verified. Open Start ShotPal.cmd to launch.
pause
