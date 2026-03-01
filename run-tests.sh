#!/bin/bash
# ============================================================
#  run-tests.sh — Run Appium tests locally on Linux/Mac
# ============================================================

set -e

echo ""
echo "==================================================="
echo " Minimal-Todo Appium Test Runner (Linux/Mac)"
echo "==================================================="
echo ""

# --- Check prerequisites ---
command -v java   >/dev/null 2>&1 || { echo "[ERROR] Java not found. Install JDK 11+."; exit 1; }
command -v mvn    >/dev/null 2>&1 || { echo "[ERROR] Maven not found. Install Maven."; exit 1; }
command -v appium >/dev/null 2>&1 || { echo "[ERROR] Appium not found. Run: npm install -g appium"; exit 1; }
command -v adb    >/dev/null 2>&1 || { echo "[ERROR] ADB not found. Set ANDROID_HOME."; exit 1; }
command -v allure >/dev/null 2>&1 || echo "[WARN]  Allure CLI not found. Install from https://docs.qameta.io/allure/"

echo "[OK] Prerequisites checked."
echo ""

# --- Check for running device / emulator ---
echo "Connected Android devices:"
adb devices | grep -v "List"
echo ""

# --- Start Appium server in background ---
echo "Starting Appium server on port 4723..."
appium --address 127.0.0.1 --port 4723 > appium.log 2>&1 &
APPIUM_PID=$!
echo "Waiting 5 seconds for Appium to start..."
sleep 5
echo "[OK] Appium server started (PID: $APPIUM_PID, log: appium.log)"
echo ""

# --- Run Maven tests ---
echo "Running tests via Maven..."
echo ""
set +e   # don't exit on test failures
mvn test
TEST_EXIT=$?
set -e

# --- Generate Allure Report ---
echo ""
if command -v allure >/dev/null 2>&1; then
    echo "Generating Allure report..."
    allure generate target/allure-results --clean -o target/allure-report
    echo "[OK] Report saved to: target/allure-report/index.html"
    # Open on macOS
    if [ "$(uname)" = "Darwin" ]; then
        open target/allure-report/index.html
    else
        echo "Open target/allure-report/index.html in your browser."
    fi
else
    echo "Generating fallback surefire HTML report..."
    mvn surefire-report:report-only -q
    echo "[OK] Report saved to: target/site/surefire-report.html"
    if [ "$(uname)" = "Darwin" ] && [ -f "target/site/surefire-report.html" ]; then
        open target/site/surefire-report.html
    fi
fi

# --- Stop Appium ---
kill $APPIUM_PID 2>/dev/null || true

echo ""
echo "==================================================="
echo " Test run complete!"
echo "==================================================="
echo ""

exit $TEST_EXIT
