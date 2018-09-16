#! /usr/bin/env bash

_python_pip_uninstall_all() {

    local item

    while IFS= read -r item
    do
        pip uninstall -y "$item"
    done < <(pip list --format freeze | s -o '(?<=^).*?(?==)' | s -v '(lxml|pip|setuptools)')
}

_python_pip_upgrade_all() {
    echo "Searching for outdated packages ..."

    local item

    while IFS= read -r item;
    do
        echo "Upgrading $item"
        pip install --user --upgrade "$item"
    done < <(pip list --outdated | s -o '(?<=^).*?(?=\ \()')
}

_python_pip_check_package() {
    if _is_command_exist pip;then
        if ! _is_command_exist 'howdoi';then
            echo "pip : howdoi is not installed!"
            if [[ "$(_check_os)" == 'Linux' ]];then
                echo "in ubuntu, in order to install howdoi we need 'apt-get install libxml2-dev libxslt-dev' first"
            fi
        fi

        if ! _is_command_exist 'pypw';then
            echo "pip : pypw is not installed!"
        fi

        if ! _is_command_exist 'repren';then
            echo "pip: repren is not installed!"
        fi
    fi
}
