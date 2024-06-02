#!/bin/bash

LANG="All"
BROWSER="Chromium"
HUB="localhost"

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
    --hub)
      HUB="$2"
      shift 2
      ;;
    --docker)
      DOCKER="$2"
      shift 2
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

# Change variable values to lowercase
LANG=${LANG,,}
BROWSER=${BROWSER,,}

rm -rf reporting/*

#
# Python tests
#
if [ $LANG = "python" ] || [ $LANG = "all" ]; then
  cd tests-python
  export PYTHONPATH=$(pwd)
  if [ $DOCKER = "playwright" ]; then
    behave cucumber/features/petstore.feature
    # pytest web_playwright/tests/webform_test.py
    pytest web_playwright/tests/ --browser $BROWSER
  else
    pytest web_selenium/tests/ --driver $BROWSER --hub $HUB
  fi
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
  # npx cypress run --browser chrome
  # npx playwright test webform.spec.ts --project chromium
  npx playwright test --project $BROWSER
  # npx cypress run
  cd ..
fi


#
# Java tests
#
if [ $LANG = "java" ] || [ $LANG = "all" ]; then
  cd tests-java
  if [ $DOCKER = "playwright" ]; then
    # mvn -Dtest="web_playwright/WebFormTest" test
    mvn -Dtest="web_playwright/**, rest_assured/**" -Dbrowser=$BROWSER test
  elif [ $DOCKER = "selenium" ]; then
    mvn -Dtest="web_selenium/**" -Dbrowser=$BROWSER -Dhub=$HUB test
  elif [ $DOCKER = "karate" ]; then
    # mvn -Dtest="web_karate/**, rest_api_karate/**" -Dbrowser="chrome" test
    mvn -Dtest="karate/**" -Dbrowser=$BROWSER test
    for filename in ../reporting/allure-results/java/*result.json; do
      RES=$(egrep '"testCaseName":"\[[0-9]+:[0-9]+\]' $filename)
      if [ -n "$RES" ]; then
        rm -f $filename
      fi
    done
  fi
  cd ..
fi

