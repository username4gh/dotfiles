#! /usr/bin/env bash

# https://stackoverflow.com/questions/5431909/bash-functions-return-boolean-to-be-used-in-if

_is_env_exist() {
    [[ "$#" -eq 1 ]] && [[ ! -z "$1" ]]
}

_is_dir_exist() {
    [[ "$#" -eq 1 ]] && [[ ! -n "$1" ]] && [[ -d "$1" ]]
}

_is_file_exist() {
    [[ "$#" -eq 1 ]] && [[ ! -n "$1" ]] && [[ -f "$1" ]]
}

_is_darwin() {
    [[ "$#" -eq 0 ]] && [[ "$(uname -s)" == "Darwin" ]]
}

_is_linux() {
    [[ "$#" -eq 0 ]] && [[ "$(uname -s)" == "Linux" ]]
}

_is_mingw32_nt() {
    [[ "$#" -eq 0 ]] && [[ "$(uname -s)" == "MINGW32_NT" ]]
}

_is_command_exist() {
    [[ "$#" -eq 1 ]] && command -v "$1" > /dev/null
}

_is_root() {
    [[ "$#" -eq 0 ]] && [[ "$(i -iu)" -ne 0 ]]
}

_is_termux() {
    _is_linux && [[ "$HOME" =~ "com.termux/files/home" ]]
}
