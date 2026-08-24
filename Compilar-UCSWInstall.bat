@echo off
setlocal

set "PAUSE_AFTER_BUILD=1"
for %%A in (%*) do if /I "%%~A"=="-NoPause" set "PAUSE_AFTER_BUILD=0"

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0Compilar-UCSWInstall.ps1" %*
set "BUILD_EXIT_CODE=%ERRORLEVEL%"

if not "%BUILD_EXIT_CODE%"=="0" (
    echo.
    echo Falha ao compilar o UCSWInstall.
) else (
    echo.
    echo UCSWInstall compilado com sucesso.
)

if "%PAUSE_AFTER_BUILD%"=="1" pause
exit /b %BUILD_EXIT_CODE%
