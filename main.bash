#!/usr/bin/env bash

# If not running interactively, don't do anything
# this line has to be placed at this front-pos,
# otherwise the rsync will not work
case $- in
    *i*) ;;
    *) return;; # exit also causing the scp command malfunction
esac

# http://mivok.net/2009/09/20/bashfunctionoverrist.html
_overrideFunction() {
    local -r functionBody=$(declare -f $1)
    local -r newDefinition="${1}_super ${functionBody#$1}"
    eval "$newDefinition"
}

# https://stackoverflow.com/questions/5431909/bash-functions-return-boolean-to-be-used-in-if
_is_shell_variable_setted() {
    [[ "$#" -eq 1 ]] && [[ -v "$1" ]]
}

_is_darwin() {
    [[ "$#" -eq 0 ]] && [[ "$(uname -s)" =~ "Darwin" ]]
}

_is_linux() {
    [[ "$#" -eq 0 ]] && [[ "$(uname -s)" =~ "Linux" ]]
}

_is_mingw32_nt() {
    [[ "$#" -eq 0 ]] && [[ "$(uname -s)" =~ "MINGW32_NT" ]]
}

_getent_wrapper() {
    if _is_darwin;then
        _getent "$@"
    else
        getent "$@"
    fi
}

_expand_path() {
    # https://stackoverflow.com/questions/3963716/how-to-manually-expand-a-special-variable-ex-tilde-in-bash
    local path
    local -a pathElements resultPathElements
    IFS=':' read -r -a pathElements <<<"$1"
    : "${pathElements[@]}"
    for path in "${pathElements[@]}"; do
        : "$path"
        case $path in
            "~+"/*)
                path=$PWD/${path#"~+/"}
                ;;
            "~-"/*)
                path=$OLDPWD/${path#"~-/"}
                ;;
            "~"/*)
                path=$HOME/${path#"~/"}
                ;;
            "~"*)
                username=${path%%/*}
                username=${username#"~"}
                homedir=$(_getent_wrapper passwd "${username}" | cut -d : -f6)
                if [[ $path = */* ]]; then
                    path=${homedir}/${path#*/}
                else
                    path=$homedir
                fi
                ;;
        esac
        resultPathElements+=( "$path" )
    done
    local result
    printf -v result '%s:' "${resultPathElements[@]}"
    printf '%s\n' "${result%:}"
}

# https://docstore.mik.ua/orelly/unix3/upt/ch29_13.htm
# export function to subshell
typeset -fx _expand_path

_is_dir_exist() {
    # here we use _expand_path to avoid the case: "$1" contains '~' and cannot do tilde-expansion correctly because of the use of single-quote or double-quote
    [[ "$#" -eq 1 ]] && [[ -d "$(_expand_path ${1})" ]]
}

typeset -fx _is_dir_exist

_is_file_exist() {
    [[ "$#" -eq 1 ]] && [[ -e "$(_expand_path ${1})" ]]
}

typeset -fx _is_file_exist



_is_command_exist() {
    [[ "$#" -eq 1 ]] && command -v "$1" > /dev/null
}

_is_root() {
    [[ "$#" -eq 0 ]] && [[ "$(id -u)" -ne 0 ]]
}

_is_not_root() {
    [[ "$#" -eq 0 ]] && [[ "$(whoami)" != root ]]
}

_is_termux() {
    _is_linux && [[ "$HOME" =~ "com.termux/files/home" ]]
}

# bash boolean support
_true() {
    [[ "true" =~ "true" ]]
}

_false() {
    ! _true
}

_set_true() {
    declare -g -n ref="${1}"

    local -r hook="_true"
    local -r function_body="$(declare -f $hook)"
    local -r definition="${!ref} ${function_body#$hook}"
    eval "$definition"
}

_set_false() {
    declare -g -n ref="${1}"

    local -r hook="_false"
    local -r function_body="$(declare -f $hook)"
    local -r definition="${!ref} ${function_body#$hook}"
    eval "$definition"
}

if ! _is_shell_variable_setted 'MY_CURRENT_SHELL';then
    echo "missing bash variable: MY_CURRENT_SHELL, valid value are \'bash\' or \'zsh\'"
    return 1
fi

# format is : command1|command1_alternative1|command1_alternative2|...;command2
prerequisite_commands='cut|gcut;python'

while read -d ';' item;do
    _set_false 'command_exist'
    while read -d '|' cmd; do
        if _is_command_exist "$cmd";then
            _set_true 'command_exist'
            break
        fi
    done< <(echo ${item})
    if ! command_exist;then
        echo "$item: command not exist"
        return 1
    fi
done< <(echo ${prerequisite_commands})

_is_bash() {
    [[ "$MY_CURRENT_SHELL" =~ 'bash' ]]
}

_is_zsh() {
    [[ "$MY_CURRENT_SHELL" =~ 'zsh' ]]
}

if _is_darwin;then
    if _is_file_exist '/opt/local/bin/port';then
        export MY_CURRENT_PACKAGE_MANAGER='macports'
    elif _is_file_exist '/usr/local/bin/brew';then
        export MY_CURRENT_PACKAGE_MANAGER='homebrew'
    else
        unset MY_CURRENT_PACKAGE_MANAGER
    fi
else
    unset MY_CURRENT_PACKAGE_MANAGER
fi

if _is_file_exist "$HOME/.dotfiles/sh/init.bash";then
    source "$HOME/.dotfiles/sh/init.bash"
fi
