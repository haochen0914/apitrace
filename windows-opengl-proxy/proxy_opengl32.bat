@echo off
REM Replace system opengl32.dll with custom 32/64-bit from .\x32-bit\ and .\x64-bit\ (same dir as this bat)
REM Ensures admin: if not elevated, asks UAC and re-launches as administrator.

REM Ensure running as Administrator (net session fails unless admin)
net session >nul 2>&1
if errorlevel 1 (
    echo This script must run as Administrator. Requesting elevation...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b 0
)
echo Running as Administrator. OK.
echo.

REM %~dp0 = directory where this bat file is (with trailing \)
set "SCRIPT_DIR=%~dp0"
set "SOURCE_32=%SCRIPT_DIR%x32-bit\opengl32.dll"
set "SOURCE_64=%SCRIPT_DIR%x64-bit\opengl32.dll"

if not exist "%SOURCE_32%" (
    echo Error: %SOURCE_32% not found.
    pause
    exit /b 1
)
if not exist "%SOURCE_64%" (
    echo Error: %SOURCE_64% not found.
    pause
    exit /b 1
)

REM /a = assign ownership to Administrators group (needed for system files)
echo === SysWOW64 (32-bit) ===
cd /d C:\Windows\SysWOW64\
if exist "opengl32_orig.dll" (
    echo opengl32_orig.dll already exists, only replace opengl32.dll
) else (
    takeown /f opengl32.dll /a
    icacls opengl32.dll /grant administrators:F
    ren "opengl32.dll" "opengl32_orig.dll"
)
takeown /f opengl32.dll /a 2>nul
icacls opengl32.dll /grant administrators:F >nul 2>&1
copy /Y "%SOURCE_32%" "C:\Windows\SysWOW64\opengl32.dll"
if errorlevel 1 ( echo Copy to SysWOW64 failed. & pause & exit /b 1 )
echo SysWOW64 done.

echo.
echo === System32 (64-bit) ===
cd /d C:\Windows\System32\
if exist "opengl32_orig.dll" (
    echo opengl32_orig.dll already exists, only replace opengl32.dll
) else (
    takeown /f opengl32.dll /a
    icacls opengl32.dll /grant administrators:F
    ren "opengl32.dll" "opengl32_orig.dll"
)
takeown /f opengl32.dll /a 2>nul
icacls opengl32.dll /grant administrators:F >nul 2>&1
copy /Y "%SOURCE_64%" "C:\Windows\System32\opengl32.dll"
if errorlevel 1 ( echo Copy to System32 failed. & pause & exit /b 1 )
echo System32 done.

echo.
echo Install completed.
pause
