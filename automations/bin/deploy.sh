#!/bin/bash

if [ "$component" = "helm" ]; then
    rm -rf deploy_helm_tmp
    mkdir -p deploy_helm_tmp
    tar xfz "$helm_chart_path" -C ./deploy_helm_tmp
    
    set -o xtrace
    
    #sed -i 's/version_oe/'$version'/g' ./charts/$helm_values_path
    #sed -i 's/version_oe/'$version'/g' ./deploy_helm_tmp/$helm_values_path
    
    echo "#" > "Helm command.log"
    echo "##########################################################################" >> "Helm command.log"
    echo "#########  Executing helm dry run" >> "Helm command.log"
    echo "##########################################################################" >> "Helm command.log"
    echo "#" >> "Helm command.log"
    (helm upgrade --dry-run --timeout 3m --install --atomic --cleanup-on-fail --debug -f "./deploy_helm_tmp/$helm_values_path" --set docker.image.version="$version" "$helm_release_name" ./deploy_helm_tmp || true) 2>&1 | tee -a "Helm command.log"
    
    echo "#" >> "Helm command.log"
    echo "##########################################################################" >> "Helm command.log"
    echo "#########  Executing helm upgrade" >> "Helm command.log"
    echo "##########################################################################" >> "Helm command.log"
    echo "#" >> "Helm command.log"
    (helm upgrade --timeout 3m --install --atomic --cleanup-on-fail --debug -f "./deploy_helm_tmp/$helm_values_path" --set docker.image.version="$version" "$helm_release_name" ./deploy_helm_tmp || echo "Helm command failed!") 2>&1 | tee -a "Helm command.log"
    
    if grep -q "Helm command failed!" "Helm command.log"; then
        exit 1
    fi
fi

if [ "$component" = "flyway" ]; then
    rm -rf deploy_flyway_tmp
    mkdir -p deploy_flyway_tmp
    tar xfz "$flyway_package_path" -C ./deploy_flyway_tmp
    cd deploy_flyway_tmp
    
    cmd="mvn -s ../.m2/settings.xml -Dflyway.configFile=$flyway_config_file flyway:repair flyway:migrate"

    set -o xtrace
    eval $cmd 2>&1 | tee -a "../Flyway execution.log"

    if ! grep -q "BUILD SUCCESS" "../Flyway execution.log"; then
        exit 1
    fi
	fi