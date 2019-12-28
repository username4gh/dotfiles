#! /usr/bin/env bash

_python_pip_uninstall_all() {
    if [[ "$#" -ne 1 ]];then
        return
    fi

    local item

    while IFS= read -r item
    do
        $@ uninstall -y "$item"
    done < <($@ list --format freeze | cut -d '=' -f1 | pythongrep -v '(lxml|pip|setuptools)')
}

alias _python_pip2_uninstall_all='_python_pip_uninstall_all pip2'
alias _python_pip3_uninstall_all='_python_pip_uninstall_all pip3'

_python_pip_upgrade_all() {
    if [[ "$#" -ne 1 ]];then
        return
    fi
    
    echo "Searching for outdated packages ..."

    local item

    while IFS= read -r item;
    do
        echo "Upgrading $item"
        $@ install --user --upgrade "$item"
    done < <($@ list -o --format freeze | cut -d '=' -f1)
}

alias _python_pip2_upgrade_all='_python_pip_upgrade_all pip2'
alias _python_pip3_upgrade_all='_python_pip_upgrade_all pip3'
