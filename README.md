# DevOps Assignment 1: Mobile Test Automation

## Project Overview
This project is an Appium-based automated testing framework for the Minimal-Todo Android app. It implements the **Page Object Model (POM)** design pattern using Java, Appium, and TestNG.

## Tools & Technologies Used
- **Language**: Java 11
- **Testing Framework**: TestNG
- **Mobile Automation**: Appium (UiAutomator2)
- **Build Tool**: Maven
- **CI/CD**: GitHub Actions
- **Containerization**: Docker & Docker Compose

## Project Structure
```
├── src/test/java/
│   ├── pages/          # Page Object Model classes
│   │   ├── BasePage.java
│   │   ├── MainPage.java
│   │   ├── AddToDoPage.java
│   │   ├── SettingsPage.java
│   │   └── AboutPage.java
│   ├── tests/          # Test classes
│   │   └── ToDoTests.java
│   └── utils/          # Utility classes
│       └── BaseTest.java
├── .github/workflows/  # CI pipeline
│   └── appium-tests.yml
├── Dockerfile          # Dockerized Appium
├── docker-compose.yml
├── pom.xml             # Maven config
├── testng.xml          # TestNG suite config
├── to_do.apk           # App under test
└── README.md
```

## Setup Instructions

### Prerequisites
1. Install Java Development Kit (JDK) 11+.
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

### Running with Docker
1. Ensure Docker and Docker Compose are installed.
2. Build and run the containerized environment:
   ```bash
   docker-compose up --build
   ```
   This will start an Appium server container and a test runner container that executes the tests automatically.

### Generating Test Reports
After running tests, generate the Allure HTML report:
```bash
allure generate target/allure-results --clean -o target/allure-report
```
Reports are saved to `target/allure-report/`.

In CI, the rendered report is automatically uploaded as an artifact and can be downloaded from the GitHub Actions run page.

**How to view the downloaded report:**
Because of browser security restrictions, the `index.html` file cannot be opened directly from the file system. You must serve it over HTTP:

```bash
# Option 1 — Python (easiest, works on Windows too)
cd allure-report
python -m http.server 8080
# then open: http://localhost:8080
```

## Test Cases (10 Functional Tests)
| # | Test Name | Description |
|---|-----------|-------------|
| 1 | testEmptyStateVisibleInitially | Verify empty state when no tasks exist |
| 2 | testAddNewTask | Verify adding a single new task |
| 3 | testAddMultipleTasks | Verify adding multiple tasks |
| 4 | testToDoListIsVisible | Verify list appears after adding tasks |
| 5 | testEmptyStateNotVisibleAfterAdd | Verify empty state hides after adding |
| 6 | testNavigateToSettings | Verify navigation to Settings screen |
| 7 | testReturnFromSettings | Verify returning from Settings |
| 8 | testNavigateToAbout | Verify navigation to About screen |
| 9 | testReturnFromAbout | Verify returning from About |
| 10 | testToggleNightMode | Verify toggling night mode switch |

## Git Workflow
The team follows a structured Git workflow:
- The `main` branch is protected with required PR reviews.
- No direct commits are allowed to `main`.
- All features are developed in separate feature branches.
- Branches are merged exclusively via **Pull Requests**.
- GitHub Issues are used to track all tasks.
- Meaningful commit messages reference issues (e.g., `Resolves #1`).

## Continuous Integration (CI)
The project uses GitHub Actions (`.github/workflows/appium-tests.yml`).
On every `push` to `main` and `pull_request`, the CI pipeline:
1. Sets up JDK 17 environment.
2. Enables KVM for hardware-accelerated Android emulator.
3. Installs Appium and UiAutomator2 driver.
4. Boots a headless Android Emulator (API 29, x86_64).
5. Executes the TestNG suite via `mvn test`.
6. Generates HTML test reports.
7. Uploads test reports as downloadable artifacts.

## Bonus Features
- **Parallel Test Execution**: TestNG configured with `parallel="methods"` and `thread-count="2"` for concurrent test execution.
- **Test Report Generation**: Maven Surefire Report plugin generates HTML reports; CI uploads them as artifacts.
- **Dockerized Appium**: `Dockerfile` and `docker-compose.yml` provided for containerized test execution.

## Team Members
- **Member 1 (whi-19)**: Framework setup, POM core, test automation, CI configuration, documentation, test reports, Docker setup.
- **Member 2 (SyedTaqii)**: POM additional screens, test automation part 2, parallel execution.
