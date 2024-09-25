#!/bin/bash

BROWSER="firefox"
HEADLESS="true"
HUB="localhost"

# Read command-line arguments
while [ $# -gt 0 ]; do
  case $1 in
    --browser)
      BROWSER="$2"
      shift 2
      ;;
    --headless)
      HEADLESS="$2"
      shift 2
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

# Change variable values to lowercase
BROWSER=${BROWSER,,}

mkdir /tmp/test
cp tests-python/file.xml /tmp/test/


echo "################"
echo "# Python tests #"
echo "################"
echo "python: "  $(python3 --version)
cd tests-python
export PYTHONPATH=$(pwd)

# pip install --break-system-packages -r requirements.txt
pip install -r requirements.txt
playwright install
rfbrowser init

echo =================
echo Python - Cucumber
echo =================
behave cucumber/features/petstore.feature
echo ===================
echo Python - Playwright
echo ===================
# pytest web_playwright/tests/webform_test.py
if [ $BROWSER = "msedge" ] || [ $BROWSER = "chrome" ]; then
  pytest web_playwright/tests/ --browser-channel $BROWSER
else
  pytest web_playwright/tests/ --browser $BROWSER
fi
echo =================
echo Python - Selenium
echo =================
pytest web_selenium/tests/ --driver $BROWSER  # --hub $HUB
echo ===============
echo Python - Pytest
echo ===============
pytest web_pytest/tests/ --driver $BROWSER \
    --alluredir /tmp \
    --html=../reporting/report-pytest/index.html \
    --css=report.css
echo ========================
echo Python - Robot Framework
echo ========================
robot --outputdir ../reporting/report-robot --variable BROWSER:${BROWSER} --variable DRIVER:headless${BROWSER} \
      --listener allure_robotframework:../reporting/allure-results/python ./

unset PYTHONPATH
cd ..


echo "#################"
echo "# Node.js tests #"
echo "#################"
echo "node.js: " $(nodejs --version)
echo "npm: " $(npm --version)
cd tests-nodejs

npm install
npx playwright install

echo ==================
echo Node.js - Cucumber
echo ==================
npx cucumber-js cucumber/features/petstore.feature
echo ====================
echo Node.js - Playwright
echo ====================
# npx playwright test webform.spec.ts
npx playwright test --project $BROWSER
echo =================
echo Node.js - Cypress
echo =================
# npx cypress run --spec web_cypress/tests/webform.cy.js
if [ $BROWSER = "msedge" ]; then
  npx cypress run --browser edge --headless
else
  npx cypress run --browser $BROWSER --headless
fi
cd ..


echo "##############"
echo "# Java tests #"
echo "##############"
echo "java: " $(java --version)
echo "maven: " $(mvn --version)
cd tests-java

mvn dependency:resolve

echo ===================
echo Java - Rest-Assured
echo ===================
mvn -Dtest="rest_api_rest_assured/**" test
echo =================
echo Java - Playwright
echo =================
# mvn -Dtest="web_playwright/WebFormTest" test
mvn -Dtest="web_playwright/**" -Dbrowser=$BROWSER test
echo ===============
echo Java - Selenium
echo ===============
mvn -Dtest="web_selenium/**" -Dbrowser=$BROWSER test  # -Dhub=$HUB test
echo =============
echo Java - Karate
echo =============
# mvn -Dtest="web_karate/**, rest_api_karate/**" -Dbrowser=$BROWSER test
# mvn -Dtest="karate/TestRunner#modularityTest" -Dbrowser=firefox test
mvn -Dtest="karate/TestRunner#allTests" -Dbrowser=$BROWSER test

# Purge weird Allure Karate entries
cd ..
mv tests-java/target/karate-reports reporting/report-karate
for filename in reporting/allure-results/java/*result.json; do
  RES=$(egrep '"testCaseName":"\[[0-9]+:[0-9]+\]' $filename)
  if [ -n "$RES" ]; then
    rm -f $filename
  fi
done
