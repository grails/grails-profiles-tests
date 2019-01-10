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

exit $EXIT_STATUS