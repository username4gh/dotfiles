#! /usr/bin/env bash

v_pyenv() {
    # https://www.topbug.net/blog/2013/10/23/use-both-homebrew-and-macports-on-your-os-x/
    if [[ "$#" -le 0 ]];then
        echo "Usage: $0 command [arg1, arg2, ...]" >&2;
        return;
    fi

    if [[ ! -d "$MY_DOTFILES_RESOURCES/pyenv" ]]; then
        echo "first time of installing pyenv? check out 'https://github.com/pyenv/pyenv/wiki'"
        git clone 'https://github.com/pyenv/pyenv' "$MY_DOTFILES_RESOURCES/pyenv"
    fi

    if _is_zsh;then
        (
        export PYENV_ROOT="$MY_DOTFILES_RESOURCES/pyenv";
        export PATH="$PYENV_ROOT/bin:$PATH";
        export PYTHONSTARTUP="$MY_DOTFILES/.pythonstartup.py";
        export PYTHONIOENCODING='UTF-8';
        export PATH="$HOME/.local/bin:$PATH";

        eval "$(pyenv init -)" && source "$PYENV_ROOT/completions/pyenv.zsh"

        command=$1

        shift

        exec $command $*
        )
    else
        (
        export PYENV_ROOT="$MY_DOTFILES_RESOURCES/pyenv";
        export PATH="$PYENV_ROOT/bin:$PATH";
        export PYTHONSTARTUP="$MY_DOTFILES/.pythonstartup.py";
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
    if [[ "$(pyenv versions | pythongrep '^\*' | pythongrep -o '(?<=\*\ ).*?(?=\ \()')" == 'system' ]];then
        echo 0
    else
        echo 1
    fi
}


_annotation_completion_write v_pyenv pip
_annotation_completion_write v_pyenv pip list
_annotation_completion_write v_pyenv pip show

_annotation_completion_write v_pyenv pyenv
_annotation_completion_write v_pyenv python
_annotation_completion_write v_pyenv sslocal
_annotation_completion_write v_pyenv sserver
_annotation_completion_write v_pyenv youtube-dl

_completion_setup v_pyenv
