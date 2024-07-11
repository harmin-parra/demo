#!/bin/bash

BROWSER="Firefox"
HUB="localhost"

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

# Change variable values to lowercase
BROWSER=${BROWSER,,}


rm -rf reporting/*
mkdir /tmp/test
cp tests-python/file.xml /tmp/test/


#
# Python tests
#
python3 --version
cd tests-python
export PYTHONPATH=$(pwd)

#pip install --break-system-packages -r requirements.txt
pip install -r requirements.txt
# playwright install-deps
playwright install
rfbrowser init

#behave cucumber/features/petstore.feature
# pytest web_playwright/tests/webform_test.py
pytest web_playwright/tests/ --browser $BROWSER
pytest web_selenium/tests/ --driver $BROWSER  # --hub $HUB
robot --outputdir ../reporting/report-robot --variable BROWSER:${BROWSER} --variable DRIVER:headless${BROWSER} ./
  # --listener allure_robotframework:../reporting/allure-results/python \
  # --outputdir ../reporting/report-robot ./

unset PYTHONPATH
cd ..


#
# Node.js tests
#
nodejs --version
npm --version
cd tests-nodejs

npm install
# npx playwright install-deps
npx playwright install

npx cucumber-js cucumber/features/petstore.feature
# npx playwright test webform.spec.ts
npx playwright test --project $BROWSER
# npx cypress run --spec web_cypress/tests/webform.cy.js
npx cypress run --browser $BROWSER --headless

cd ..


#
# Java tests
#
java --version
cd tests-java

mvn dependency:resolve

# mvn -Dtest="web_playwright/WebFormTest" test
mvn -Dtest="web_playwright/**, rest_api_rest_assured/**" -Dbrowser=$BROWSER test
mvn -Dtest="web_selenium/**" -Dbrowser=$BROWSER test  # -Dhub=$HUB test
# mvn -Dtest="web_karate/**, rest_api_karate/**" -Dbrowser="chrome" test
mvn -Dtest="karate/TestRunner#allTests" -Dbrowser=$BROWSER test

cd ..
mv tests-java/target/karate-reports reporting/report-karate
for filename in reporting/allure-results/java/*result.json; do
  RES=$(egrep '"testCaseName":"\[[0-9]+:[0-9]+\]' $filename)
  if [ -n "$RES" ]; then
    rm -f $filename
  fi
done
