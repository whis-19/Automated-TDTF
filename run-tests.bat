@echo off
REM ============================================================
REM  run-tests.bat — Run Appium tests locally on Windows
REM ============================================================

echo.
echo ===================================================
echo  Minimal-Todo Appium Test Runner (Windows)
echo ===================================================
echo.

REM --- Check prerequisites ---
where java    >nul 2>&1 || (echo [ERROR] Java not found. Install JDK 11+ and add to PATH. & exit /b 1)
where mvn     >nul 2>&1 || (echo [ERROR] Maven not found. Install Maven and add to PATH. & exit /b 1)
where appium  >nul 2>&1 || (echo [ERROR] Appium not found. Run: npm install -g appium & exit /b 1)
where adb     >nul 2>&1 || (echo [ERROR] ADB not found. Set ANDROID_HOME and add platform-tools to PATH. & exit /b 1)
where allure  >nul 2>&1 || (echo [WARN]  Allure CLI not found. Install from https://docs.qameta.io/allure/)

echo [OK] Prerequisites checked.
echo.

REM --- Check for running emulator / device ---
echo Checking for connected Android device...
adb devices | findstr /V "List"
echo.

REM --- Start Appium server in background ---
echo Starting Appium server on port 4723...
start /B cmd /c "appium --address 127.0.0.1 --port 4723 > appium.log 2>&1"
echo Waiting 5 seconds for Appium to start...
timeout /t 5 /nobreak >nul
echo [OK] Appium server started (log: appium.log)
echo.

REM --- Run Maven tests ---
echo Running tests via Maven...
echo.
mvn test

REM --- Generate Allure Report ---
echo.
where allure >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo Generating Allure report...
    allure generate target\allure-results --clean -o target\allure-report
    echo [OK] Report saved to: target\allure-report\index.html
    echo Opening report in browser...
    start target\allure-report\index.html
) else (
    echo Generating fallback surefire HTML report...
    mvn surefire-report:report-only -q
    echo [OK] Report saved to: target\site\surefire-report.html
    if exist "target\site\surefire-report.html" start target\site\surefire-report.html
)

echo.
echo ===================================================
echo  Test run complete!
echo ===================================================
echo.
