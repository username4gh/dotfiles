#! /usr/bin/env bash

_commitizen_fix_package_json() {
    if [[ ! -f "./package.json" ]];then
        if [[ "$#" == 0 ]];then
            if [[ ! -d "$MY_REPO/cz-cli" ]];then
                git clone https://github.com/commitizen/cz-cli "$MY_REPO/cz-cli"
            fi
            cp "$MY_REPO/cz-cli/package.json" ./
        fi
    fi
}

_commitizen_init() {
    _commitizen_fix_package_json
    commitizen init cz-conventional-changelog --save-dev --save-exact --force
}
