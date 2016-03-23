#! /usr/bin/env bash

_virtual_nvm_complete () {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local enable_disable_args="git-cz npm"
    COMPREPLY=( $(compgen -W "${enable_disable_args}" -- ${cur}) )
}

complete -F _virtual_nvm_complete virtual_nvm
