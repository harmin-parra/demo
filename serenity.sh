#!/bin/bash

BROWSER="firefox"
HEADLESS="true"

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

cd tests-serenity

mvn dependency:resolve

echo ===============
echo Java - Serenity
echo ===============
mvn -Dheadless.mode=$HEADLESS -Dwebdriver.driver=$BROWSER clean verify

cd ..
mv tests-serenity/target/site/serenity reporting/report-serenity
