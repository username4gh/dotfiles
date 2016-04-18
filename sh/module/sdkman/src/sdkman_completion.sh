#! /usr/bin/env sh

if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    _virtual_sdkman_complete () {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local enable_disable_args="my_groovysh sdk"
        COMPREPLY=( $(compgen -W "${enable_disable_args}" -- ${cur}) )
    }

    complete -F _virtual_sdkman_complete virtual_sdkman
fi
