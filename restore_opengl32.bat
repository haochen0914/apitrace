@echo off
REM Restore original opengl32.dll (remove custom, rename _orig back)
REM SysWOW64 = 32-bit, System32 = 64-bit. Ensures admin before any operation.

net session >nul 2>&1
if errorlevel 1 (
    echo This script must run as Administrator. Requesting elevation...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b 0
)
echo Running as Administrator. OK.
echo.

echo === SysWOW64 (32-bit) ===
cd /d C:\Windows\SysWOW64\
if exist "opengl32_orig.dll" (
    del opengl32.dll
    ren "opengl32_orig.dll" "opengl32.dll"
    if errorlevel 1 ( echo Restore SysWOW64 failed. & pause & exit /b 1 )
    echo SysWOW64 done.
) else (
    echo opengl32_orig.dll not found, skip SysWOW64.
)

echo.
echo === System32 (64-bit) ===
cd /d C:\Windows\System32\
if exist "opengl32_orig.dll" (
    del opengl32.dll
    ren "opengl32_orig.dll" "opengl32.dll"
    if errorlevel 1 ( echo Restore System32 failed. & pause & exit /b 1 )
    echo System32 done.
) else (
    echo opengl32_orig.dll not found, skip System32.
)

echo.
echo Restore completed.
pause
