#!/bin/bash
set -e

EXIT_STATUS=0

curl -s get.sdkman.io | bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

echo sdkman_auto_answer=true > ~/.sdkman/etc/config

source "/home/travis/.sdkman/bin/sdkman-init.sh"

./gradlew build --console=plain || EXIT_STATUS=$?

if [ $EXIT_STATUS -ne 0 ]; then
  exit $EXIT_STATUS
fi

cd build/grails-wrapper/

./gradlew assemble || EXIT_STATUS=$?

if [ $EXIT_STATUS -ne 0 ]; then
  exit $EXIT_STATUS
fi

cd ../../

mkdir -p $HOME/.grails/wrapper

cp /home/travis/build/grails/grails-profiles-tests/build/grails-wrapper/wrapper/build/libs/grails4-wrapper-1.0.1.BUILD-SNAPSHOT.jar $HOME/.grails/wrapper/grails4-wrapper.jar

sdk install grails dev /home/travis/build/grails/grails-profiles-tests/build/grails-core

sdk install grails

sdk use grails 3.3.3

grails --version

grails create-app demo.web

grails create-app demo.vue --profile=vue

grails create-app demo.web-jboss7 --profile=web-jboss7

grails create-app demo.react --profile=react

grails create-app demo.profile --profile=profile

grails create-app demo.rest-api --profile=rest-api

grails create-app demo.rest-api-plugin --profile=rest-api-plugin

grails create-app demo.web-plugin --profile=web-plugin

grails create-app demo.plugin --profile=plugin

grails create-app demo.webpack --profile=webpack

grails create-app demo.react-webpack --profile=react-webpack

exit $EXIT_STATUS