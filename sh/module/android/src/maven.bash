#! /usr/bin/env bash

MAVEN_PATH=$(_autodetect_bin 'apache-maven-.*')
if [[ "${#MAVEN_PATH}" -eq 0 ]];then
    _sh_log "${BASH_SOURCE[0]}" "maven has not been installed yet"
else
    export PATH="$MAVEN_PATH/bin:$PATH"
fi
