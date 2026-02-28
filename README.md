# DevOps Assignment 1: Mobile Test Automation

## Project Overview
This project is an Appium-based automated testing framework for the Minimal-Todo Android app. It implements the **Page Object Model (POM)** design pattern using Java, Appium, and TestNG.

## Tools & Technologies Used
- **Language**: Java 11
- **Testing Framework**: TestNG
- **Mobile Automation**: Appium (UiAutomator2)
- **Build Tool**: Maven
- **CI/CD**: GitHub Actions

## Setup Instructions

### Prerequisites
1. Install Java Development Kit (JDK) 11.
2. Install Maven and add it to your system PATH.
3. Install Node.js & NPM.
4. Install Appium: `npm install -g appium`.
5. Install Appium UiAutomator2 Driver: `appium driver install uiautomator2`.
6. Install Android Studio and set up `ANDROID_HOME` / emulator.

### Running Tests Locally
1. Start an Android Emulator via Android Studio or command line.
2. Start the Appium Server by running `appium` in your terminal.
3. Clone the repository and navigate to the project directory.
4. Run the TestNG suite using Maven:
   ```bash
   mvn test
   ```

## Git Workflow
The team follows a structured Git workflow:
- The `main` branch is protected.
- No direct commits are allowed to `main`.
- All features and tests have been developed in separate branches.
- Branches are merged exclusively via **Pull Requests**.

## Continuous Integration (CI)
The project is configured with GitHub Actions (`.github/workflows/appium-tests.yml`). 
On every `push` to `main` and `pull_request`, the CI pipeline automatically:
1. Sets up the JDK environment.
2. Installs Appium and necessary drivers.
3. Boots a headless Android Emulator.
4. Executes the automated TestNG suite via `mvn test`.