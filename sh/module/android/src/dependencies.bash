#! /usr/bin/env bash

my_android_dependencies_list_duplicated() {
    if [[ -f "./settings.gradle" ]];then
        while IFS= read -r -d '' item
        do
            echo $item
        done< <(find . -type f -name "*.jar")
    fi
}
