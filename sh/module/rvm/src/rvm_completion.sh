#! /usr/bin/env bash

_virtual_rvm_complete () {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local enable_disable_args="rvm"
    COMPREPLY=( $(compgen -W "${enable_disable_args}" -- ${cur}) )
}

complete -F _virtual_rvm_complete virtual_rvm