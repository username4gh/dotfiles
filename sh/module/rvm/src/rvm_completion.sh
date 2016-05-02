#! /usr/bin/env sh

if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    _virtual_rvm_complete () {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local completion_args="alfi gem rvm"
        COMPREPLY=( $(compgen -W "${completion_args}" -- ${cur}) )
    }

    complete -F _virtual_rvm_complete virtual_rvm
fi
