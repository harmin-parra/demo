#!/bin/bash

EXECUTOR_NAME="Github Actions"
EXECUTOR_TYPE="github"

# Read command-line arguments
while [ $# -gt 0 ]; do
  case $1 in
    --browser)
      BROWSER="$2"
      shift 2
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

# Browser with initial uppercase
BROWSER=${BROWSER,,}
BROWSER=${BROWSER^}

#
# Java tests
#
cat << EOF > reporting/allure-results/java/environment.properties
Browser = $BROWSER
OpenJDK = 17
Selenium = 4.21.0
Playwright = 1.44.0
Rest-assured = 5.4.0
Karate = 1.4.1
EOF
#Cucumber-JVM = 7.15.0

if [ -f reporting/allure-results/java/job.url ]; then
  cat << EOF > reporting/allure-results/java/executor.json
{
  "name": "${EXECUTOR_NAME}",
  "type": "${EXECUTOR_TYPE}",
  "buildName": "Build log",
  "buildUrl": "$(cat reporting/allure-results/java/job.url)",
  "reportName": "Demo Java report"
}
EOF
fi

allure generate \
  --clean \
  --output reporting/allure-reports/report-java \
  --single-file reporting/allure-results/java

#
# Node.js tests
#
cat << EOF > reporting/allure-results/nodejs/environment.properties
Browser = $BROWSER
Node.js = 20.13.1
Playwright = 1.44.1
Cucumber.js = 10.3.1
EOF

if [ -f reporting/allure-results/nodejs/job.url ]; then
  cat << EOF > reporting/allure-results/nodejs/executor.json
{
  "name": "${EXECUTOR_NAME}",
  "type": "${EXECUTOR_TYPE}",
  "buildName": "Build log",
  "buildUrl": "$(cat reporting/allure-results/nodejs/job.url)",
  "reportName": "Demo Node.js report"
}
EOF
fi

allure generate \
  --clean \
  --output reporting/allure-reports/report-nodejs \
  --single-file reporting/allure-results/nodejs

#
# Python tests
#
cat << EOF > reporting/allure-results/python/environment.properties
Browser = $BROWSER
Python = 3.10.12
Behave = 1.2.6
Selenium = 4.21.0
Playwright = 1.44.0
RobotFramework = 7.0
EOF

if [ -f reporting/allure-results/python/job.url ]; then
  cat << EOF > reporting/allure-results/python/executor.json
{
  "name": "${EXECUTOR_NAME}",
  "type": "${EXECUTOR_TYPE}",
  "buildName": "Build log",
  "buildUrl": "$(cat reporting/allure-results/python/job.url)",
  "reportName": "Demo Python report"
}
EOF
fi

allure generate \
  --clean \
  --output reporting/allure-reports/report-python \
  --single-file reporting/allure-results/python
