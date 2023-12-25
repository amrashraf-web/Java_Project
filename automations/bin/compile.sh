#!/bin/bash

baseline_cmd="mvn clean package"

if ! test -z "$sonar_url" 
then
	sonar_extra_arguments="sonar:sonar -Dsonar.host.url=\"$sonar_url\" -Dsonar.login=sqa_abe2308983442607b86fb259f6ed2ab6621ad6d5 -Dsonar.projectKey=\"$sonar_project_key\" -Dsonar.projectName=\"$sonar_project_name\" -Dsonar.java.coveragePlugin=jacoco -Dsonar.dynamicAnalysis=reuseReports -P sonar -Dsonar.scm.disabled=true -Dsonar.projectVersion=\"$version\""
fi

set -o xtrace
eval $baseline_cmd $maven_extra_arguments $sonar_extra_arguments
