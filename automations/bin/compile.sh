#!/bin/bash

baseline_cmd="mvn clean package  -U"

sonar_extra_arguments="sonar:sonar -Dsonar.host.url=\"$sonar_url\" -Dsonar.login=squ_ebc1b937797343e26be57ce1eef2f6f869a2fdb3 -Dsonar.projectKey=\"$sonar_project_key\" -Dsonar.projectName=\"$sonar_project_name\"  -Dsonar.projectVersion=\"$version\""

set -o xtrace
eval $baseline_cmd $maven_extra_arguments $sonar_extra_arguments
