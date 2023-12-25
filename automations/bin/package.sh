#!/bin/bash

set -e


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$SCRIPT_DIR/../.."

set -o xtrace

if ! test -z "$image_tag" 
then
    docker rmi $image_tag || true
    pwd
    jar_fullpath=$(find publish-artifacts/*.jar)
    docker login amrashraf.com:8082 -u admin -p admin
    docker build -t "$image_tag" --build-arg JAR_FILE="$(basename $jar_fullpath)" --build-arg JAR_PATH="$(dirname $jar_fullpath)/" .
fi

if ! test -z "$helm_package_path"
then
    cd charts
    find . -name 'values_*.yml' | xargs -I{} sed -i "s#PLACEHOLDER_VERSION#$version#g" "{}" && tar cfz "$SCRIPT_DIR/../../$helm_package_path" ./*
fi