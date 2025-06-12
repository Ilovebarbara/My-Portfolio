@echo off
echo.
echo ========================================
echo   Jodeo Portfolio - Quick Deploy
echo ========================================
echo.

REM Check if gcloud is installed
where gcloud >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Google Cloud SDK not found!
    echo Please install it from: https://cloud.google.com/sdk/docs/install
    pause
    exit /b 1
)

echo ✅ Google Cloud SDK found
echo.

REM Get current project
for /f "tokens=*" %%i in ('gcloud config get-value project 2^>nul') do set PROJECT_ID=%%i

if "%PROJECT_ID%"=="" (
    echo ⚠️  No project configured
    set /p PROJECT_ID="Enter your Google Cloud Project ID: "
    gcloud config set project %PROJECT_ID%
)

echo 🚀 Current Project: %PROJECT_ID%
echo.

echo 📦 Deploying to App Engine...
gcloud app deploy --quiet

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ Deployment successful!
    echo 🌐 Opening your portfolio...
    gcloud app browse
    echo.
    echo 📊 Useful commands:
    echo   - View logs: gcloud app logs tail -s default
    echo   - List versions: gcloud app versions list
    echo   - Add domain: gcloud app domain-mappings create yourdomain.com
) else (
    echo.
    echo ❌ Deployment failed!
    echo Check the logs above for errors.
)

echo.
pause
