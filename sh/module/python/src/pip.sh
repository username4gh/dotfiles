#! /usr/bin/env sh

_python_pip_uninstall_all() {

    local item

    while IFS= read -r item
    do
        if [[ "$item" != 'pip' ]] && [[ "$item" != 'setuptools' ]] && [[ "$item" != 'lxml' ]];then
            pip uninstall -y "$item"
        fi
    done < <(pip list | s -o '(?<=^).*?(?=\ \()')
}

_python_pip_upgrade_all() {
    echo "Searching for outdated packages ..."

    local item

    while IFS= read -r item; 
    do
        echo "Upgrading $item"
        pip install --upgrade "$item"
    done < <(pip list --outdated | s -o '(?<=^).*?(?=\ \()')
}

_python_pip_check_package() {
    if [[ "$(_check_command pip)" == 1 ]];then
        if [[ "$(_check_command 'howdoi')" == 0 ]];then
            echo "pip : howdoi is not installed!"
            if [[ "$(_check_os)" == 'Linux' ]];then
                echo "in ubuntu, in order to install howdoi we need 'apt-get install libxml2-dev libxslt-dev' first"
            fi
        fi

        if [[ "$(_check_command 'pypw')" == 0 ]];then
            echo "pip : pypw is not installed!"
        fi

        if [[ "$(_check_command 'repren')" == 0 ]];then
            echo "pip: repren is not installed!"
        fi
    fi
}
