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

echo "[OK] All prerequisites found."
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
mvn test

# --- Generate HTML report ---
echo ""
echo "Generating HTML test report..."
mvn surefire-report:report-only -q

echo ""
echo "==================================================="
echo " Test run complete!"
echo " Report: target/site/surefire-report.html"
echo "==================================================="
echo ""

# --- Stop Appium ---
kill $APPIUM_PID 2>/dev/null

# --- Open report (macOS) ---
if [ "$(uname)" = "Darwin" ] && [ -f "target/site/surefire-report.html" ]; then
    open target/site/surefire-report.html
fi
