#!/bin/bash
set -e

EXIT_STATUS=0

grails create-app demo --profile=react || EXIT_STATUS=$?

if [ $EXIT_STATUS -ne 0 ]; then
  exit $EXIT_STATUS
fi

cd demo

./gradlew server:check

if [ $EXIT_STATUS -ne 0 ]; then
  exit $EXIT_STATUS
fi

cd ..

rm -rf demo

exit $EXIT_STATUS