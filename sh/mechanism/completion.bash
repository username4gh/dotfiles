#! /usr/bin/env bash

_completion_read() {
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        # $1 --> variant name
        if [[ "$#" == 1 ]];then
            if [[ -f "$MY_I3/completion/$1.completion" ]];then
                echo $(cat "$MY_I3/completion/$1.completion")
            fi
        else
            echo "Usage: _completion_read parent"
        fi
    fi
}

_completion_write() {
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        # $1 --> variant name
        # $2 --> variant value
        if [[ "$#" == 2 ]];then
            if [[ ! -d "$MY_I3/completion" ]];then
                mkdir -p "$MY_I3/completion"
            fi

            if [[ -f "$MY_I3/completion/$1.completion" ]];then
                # delete old record, we need the gnu sed to achieve it
                sed -e "/$2/d" -i.tmp $MY_I3/completion/$1.completion
            fi

            echo "$2" >> $MY_I3/completion/$1.completion
        else
            echo "Usage: _completion_write parent child"
        fi
    fi
}

_completion_generate() {
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        # $1 target command
        # $2 pattern to match file in target directory
        for f in $2;
        do
            _completion_write $1 $(basename $f | cut -d '.' -f1)
        done
    fi
}

_completion_complete () {
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local completion_args="$(_completion_read $1)"
        COMPREPLY=( $(compgen -W "${completion_args}" -- ${cur}) )
    fi
}

_completion_setup() {
    # $1 target command
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        complete -F _completion_complete $1
    fi
}
