#!/bin/bash

LANG="All"

# Read command-line arguments
while [ $# -gt 0 ]; do
  case $1 in
    --lang)
      LANG="$2"
      shift 2
      ;;
    --browser)
      BROWSER="$2"
      shift 2
      ;;
    --job-nodejs)
      JOB_NODEJS="$2"
      shift 2
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

LANG=${LANG,,}
BROWSER=${BROWSER,,}
BROWSER=${BROWSER^}

#
# Java tests
#
if [ $LANG == "java" ] || [ $LANG == "all" ]; then
  cat << EOF > reporting/allure-results/java1/environment.properties
Browser = $BROWSER
OpenJDK = 17
Playwright = 1.41.0
Cucumber-JVM = 7.15.0
Rest-assured = 5.4.0
EOF

  if [ -f reporting/allure-results/java1/job.url ]; then
    cat << EOF > reporting/allure-results/java1/executor.json
{
  "name": "Github Actions",
  "type": "github",
  "buildName": "Build log",
  "buildUrl": "$(cat reporting/allure-results/java1/job.url)",
  "reportName": "Demo Java report"
}
EOF
  fi

  if [ -f reporting/allure-results/java2/job.url ]; then
    cat << EOF > reporting/allure-results/java2/executor.json
{
  "name": "Github Actions",
  "type": "github",
  "buildName": "Build log",
  "buildUrl": "$(cat reporting/allure-results/java2/job.url)",
  "reportName": "Demo Java report"
}
EOF
  fi

  allure generate \
    --clean \
    --output reporting/allure-reports/java \
    --single-file reporting/allure-results/java1 reporting/allure-results/java2
fi

#
# Node.js tests
#
if [ $LANG == "node.js" ] || [ $LANG == "all" ]; then
  cat << EOF > reporting/allure-results/nodejs-results/environment.properties
Browser = $BROWSER
Node.js = 20.11.0
Playwright = 1.41.1
Cucumber.js = 10.3.1
EOF

  cat << EOF > reporting/allure-results/nodejs-results/executor.json
{
  "name": "Github Actions",
  "type": "github",
  "buildName": "Build log",
  "buildUrl": "${JOB_NODEJS}",
  "reportName": "Demo Node.js report"
}
EOF

  allure generate \
    --clean \
    --output reporting/allure-reports/report-nodejs \
    --single-file reporting/allure-results/nodejs-results
fi

#
# Python tests
#
if [ $LANG == "python" ] || [ $LANG == "all" ]; then
  cat << EOF > reporting/allure-results/python1/environment.properties
Browser = $BROWSER
Python = 3.10.12
Playwright = 1.41.0
Behave = 1.2.6
EOF

  if [ -f reporting/allure-results/python1/job.url ]; then
    cat << EOF > reporting/allure-results/python1/executor.json
{
  "name": "Github Actions",
  "type": "github",
  "buildName": "Build log",
  "buildUrl": "$(cat reporting/allure-results/python1/job.url)",
  "reportName": "Demo Java report"
}
EOF
  fi

  if [ -f reporting/allure-results/python2/job.url ]; then
    cat << EOF > reporting/allure-results/python2/executor.json
{
  "name": "Github Actions",
  "type": "github",
  "buildName": "Build log",
  "buildUrl": "$(cat reporting/allure-results/python2/job.url)",
  "reportName": "Demo Java report"
}
EOF
  fi

  allure generate \
    --clean \
    --output reporting/allure-reports/python \
    --single-file reporting/allure-results/python1 reporting/allure-results/python2

fi

