#!/bin/bash

LANG="All"

# Read command-line arguments
while [ $# -gt 0 ]; do
  case $1 in
    --lang)
      LANG="$2"
      shift 2
      ;;
    --job-java)
      JOB_JAVA="$2"
      shift 2
      ;;
    --job-nodejs)
      JOB_NODEJS="$2"
      shift 2
      ;;
    --job-python)
      JOB_PYTHON="$2"
      shift 2
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

LANG=${LANG,,}

#
# Java tests
#
if [ $LANG == "java" ] || [ $LANG == "all" ]; then
  cat << EOF > reporting/allure-results/java/environment.properties
OpenJDK = 17.0.9
Playwright = 1.41.0
Cucumber-JVM = 7.15.0
EOF

  cat << EOF > reporting/allure-results/java/executor.json
{
  "name": "Gitlab CI",
  "type": "gitlab",
  "buildName": "Build log",
  "buildUrl": "${JOB_JAVA}",
  "reportName": "Demo Java report"
}
EOF

  allure generate \
    --clean \
    --output reporting/allure-reports/java \
    --single-file reporting/allure-results/java
fi

#
# Node.js tests
#
if [ $LANG == "node.js" ] || [ $LANG == "all" ]; then
  cat << EOF > reporting/allure-results/nodejs-results/environment.properties
Node.js = 20.11.0
Playwright = 1.41.1
Cucumber.js = 10.3.1
EOF

  cat << EOF > reporting/allure-results/nodejs-results/executor.json
{
  "name": "Gitlab CI",
  "type": "gitlab",
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
  cat << EOF > reporting/allure-results/python-results/environment.properties
Python = 3.10.12
Playwright = 1.41.0
Behave = 1.2.6
EOF

  cat << EOF > reporting/allure-results/python-results/executor.json
{
  "name": "Gitlab CI",
  "type": "gitlab",
  "buildName": "Build log",
  "buildUrl": "${JOB_PYTHON}",
  "reportName": "Demo Python report"
}
EOF

  allure generate \
    --clean \
    --output reporting/allure-reports/report-python \
    --single-file reporting/allure-results/python-results

fi

