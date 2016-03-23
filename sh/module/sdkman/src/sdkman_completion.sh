#! /usr/bin/env bash

_virtual_sdkman_complete () {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local enable_disable_args="sdk"
    COMPREPLY=( $(compgen -W "${enable_disable_args}" -- ${cur}) )
}

complete -F _virtual_sdkman_complete virtual_sdkman
