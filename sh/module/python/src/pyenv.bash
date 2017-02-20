#! /usr/bin/env bash

v_pyenv() {
    # https://www.topbug.net/blog/2013/10/23/use-both-homebrew-and-macports-on-your-os-x/
    if [[ "$#" -le 0 ]];then
        echo "Usage: $0 command [arg1, arg2, ...]" >&2;
        return;
    fi

    if [[ ! -d "$MY_DEPENDENCIES/pyenv" ]]; then
        echo "first time of installing pyenv? check out 'https://github.com/yyuu/pyenv/wiki'"
        git clone 'https://github.com/yyuu/pyenv' "$MY_DEPENDENCIES/pyenv"
    fi

    if [[ "$MY_CURRENT_SHELL" == 'zsh' ]];then
        (
        export PYENV_ROOT="$MY_DEPENDENCIES/pyenv";
        export PATH="$PYENV_ROOT/bin:$PATH";
        export PYTHONSTARTUP="$MY_DEPENDENCIES/.pythonstartup.py";
        export PYTHONIOENCODING='UTF-8';
        export PATH="$HOME/.local/bin:$PATH";

        eval "$(pyenv init -)" && source "$PYENV_ROOT/completions/pyenv.zsh"

        command=$1

        shift

        exec $command $*
        )
    else
        (
        export PYENV_ROOT="$MY_DEPENDENCIES/pyenv";
        export PATH="$PYENV_ROOT/bin:$PATH";
        export PYTHONSTARTUP="$MY_DEPENDENCIES/.pythonstartup.py";
        export PYTHONIOENCODING='UTF-8';
        export PATH="$HOME/.local/bin:$PATH";

        eval "$(pyenv init -)" && source "$PYENV_ROOT/completions/pyenv.bash"

        command=$1

        shift

        $command $*
        )
    fi
}

_python_check_pyenv() {
    if [[ "$(pyenv versions | s '^\*' | s -o '(?<=\*\ ).*?(?=\ \()')" == 'system' ]];then
        echo 0
    else
        echo 1
    fi
}


_completion_register_write v_pyenv pip
_completion_register_write v_pyenv pip list
_completion_register_write v_pyenv pip show

_completion_register_write v_pyenv pyenv
_completion_register_write v_pyenv python
_completion_register_write v_pyenv youtube-dl

_completion_setup v_pyenv
