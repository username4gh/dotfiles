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

_commitizen_deal_with_gitignore() {
    if [[ -a "./.gitignore" ]];then
        mv ./.gitignore ./.gitignore.previous
        cat $MY_SH_MODULE/commitizen/src/commitizen_gitignore >> ./.gitignore.previous
        $MY_SH_MODULE/git/src/gitignore_merger.py -i ./.gitignore.previous -o ./.gitignore
        rm ./.gitignore.previous
    else
        cp "$MY_SH_MODULE/commitizen/src/commitizen_gitignore" ./.gitignore
    fi
}

commitizen_init() {
    if [[ -d './.git' ]];then
        _commitizen_deal_with_gitignore
        _commitizen_fix_package_json
        commitizen init cz-conventional-changelog --save-dev --save-exact --force
    else
        echo "Usage:commitizen_init must be used under the git-repo root"
    fi
}