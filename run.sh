#!/bin/bash

LANG="All"

# Read command-line arguments
while [ $# -gt 0 ]; do
  case $1 in
    --lang)
      LANG="$2"
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
# Python tests
#
if [ $LANG = "python" ] || [ $LANG = "all" ]; then
  rm -rf reporting/allure-results/python-results reporting/allure-reports/report-python reporting/playwright-report/*

  cd tests-python
  behave cucumber/features/petstore.feature
  export PYTHONPATH=$(pwd)
  # pytest web_playwright/tests/webform_test.py
  pytest web_playwright/tests/
  unset PYTHONPATH
  cd ..
fi


#
# Node.js tests
#
if [ $LANG = "node.js" ] || [ $LANG = "all" ]; then
  rm -rf reporting/allure-results/nodejs-results reporting/allure-reports/report-nodejs reporting/playwright-report/*

  cd tests-nodejs
  npx cucumber-js cucumber/features/petstore.feature
  # npx playwright test webform.spec.ts --project chromium
  npx playwright test --project chromium
  # npx cypress run
  cd ..
fi


#
# Java tests
#
if [ $LANG = "java" ] || [ $LANG = "all" ]; then
  rm -rf reporting/allure-results/java-results reporting/allure-reports/report-java reporting/playwright-report/*

  cd tests-java
  # mvn -Dtest="web_playwright/WebFormTest, cucumber/petstore/**" test
  mvn -Dtest="web_playwright/**, cucumber/petstore/**" test
  cd ..
fi
