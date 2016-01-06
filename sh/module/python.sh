#! /bin/bash
if [[ ! -d "$MY_REPO/pyenv" ]]; then
    echo "newly installed pyenv? check out 'https://github.com/yyuu/pyenv/wiki'"
    git clone 'https://github.com/yyuu/pyenv' "$MY_REPO/pyenv"
fi

export PYENV_ROOT="$MY_REPO/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYTHONSTARTUP="$MY_REPO/my-i3/.pythonstartup.py"

if [[ "$(_check_variant "$MY_CURRENT_SHELL")" == 1 ]];then
    if [[ "$MY_CURRENT_SHELL" == 'zsh' ]];then
        eval "$(pyenv init -)" \
            && source "$PYENV_ROOT/completions/pyenv.zsh"
    else
        eval "$(pyenv init -)" \
            && source "$PYENV_ROOT/completions/pyenv.bash"
    fi
fi

export PYTHONIOENCODING='UTF-8'
export PATH="$HOME/.local/bin:$PATH"

_python_pip_uninstall_all() {

    local item

    while IFS= read -r item
    do
        if [[ "$item" != 'pip' ]] && [[ "$item" != 'setuptools' ]] && [[ "$item" != 'lxml' ]];then
            pip uninstall -y "$item"
        fi
    done < <(pip list | grep -Po '(?<=^).*?(?=\ \()')
}

_python_pip_upgrade_all() {
    echo "Searching for outdated packages ..."

    local item

    while IFS= read -r item; 
    do
        echo "Upgrading $item"
        pip install --upgrade "$item"
    done < <(pip list --outdated | grep -Po '(?<=^).*?(?=\ \()')
}

_python_check_pyenv() {
    if [[ "$(pyenv versions | grep '*' | grep -Po '(?<=\*\ ).*?(?=\ \()')" == 'system' ]];then 
        echo 0
    else
        echo 1
    fi
}

if [[ "$(_python_check_pyenv)" == 1 ]];then
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
