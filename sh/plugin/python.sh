#! /bin/bash

if [[ ! -d "$HOME/repo/pyenv" ]]; then
    echo "newly installed pyenv? check out 'https://github.com/yyuu/pyenv/wiki'"
    pushd "$HOME/repo" \
        && git clone 'https://github.com/yyuu/pyenv' \
        && popd
fi

export PYENV_ROOT="$HOME/repo/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYTHONSTARTUP="$HOME/repo/my-i3/.pythonstartup.py"

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

_python_pip_upgrade_all() {
    echo "Searching for outdated packages ..."

    while IFS= read -r -d '' item; do
        local name=$("${item%\(*}" | tr --delete ' ')

        local t=$(pip show "$name" | tr --delete "[:space:]")

        if [ -n "$t" ]; then
            echo "Upgrading $name"
            if [ "$1" == 'user' ]; then
                pip install --upgrade --user "$name"
            else
                pip install --upgrade "$name"
            fi
        else
            echo "$t"
        fi
    done < <(pip list --outdated)
}

if [[ "$(_check_command 'howdoi')" == 0 ]];then
    if [[ "$(_check_os)" == 'Linux' ]];then
        echo "apt-get install libxml2-dev libxslt-dev"
    fi
    echo "pip install howdoi"
fi

if [[ "$(_check_command 'pypw')" == 0 ]];then
    echo "pip install pypw"
fi
