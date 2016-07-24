#! /usr/bin/env bash

export MY_SH_COMPLETIONS="$MY_I3/completions"

_completion_read() {
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        # $1 --> variant name
        if [[ "$#" == 1 ]];then
            if [[ -f "$MY_SH_COMPLETIONS/$1.completion" ]];then
                cat "$MY_SH_COMPLETIONS/$1.completion"
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
            if [[ ! -d "$MY_SH_COMPLETIONS" ]];then
                mkdir -p "$MY_SH_COMPLETIONS"
            fi

            if [[ -f "$MY_SH_COMPLETIONS/$1.completion" ]];then
                # delete old record, we need the gnu sed to achieve it
                sed -e "/$2/d" -i.tmp "$MY_SH_COMPLETIONS/$1.completion"
            fi

            echo "$2" >> "$MY_SH_COMPLETIONS/$1.completion"
        else
            echo "Usage: _completion_write parent child"
        fi
    fi
}

_completion_generate() {
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        # $1 target command
        # $2 directory
        # $3 pattern to match certain file
        while IFS= read -r item
        do
            _completion_write $1 $(basename $item | cut -d '.' -f1)
        done < <(find "$2" -maxdepth 1 -type f | s "$3")
    fi
}

_completion_register_write(){
    return
}

_completion_register_generate() {    
    return
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

my_completion_generate() {
    while IFS= read -r item
    do
        # deal with _completion_register_write
        while IFS= read -r line
        do
            completion_target=$(echo "$line" | awk '{print $2}')
            completion_word=$(echo "$line" | awk '{print $3}')
            _completion_write $completion_target $completion_word 
        done < <(s -f $item _completion_register_write)

        # deal with _completion_register_generate
        while IFS= read -r line
        do
            IFS=' ' read -r -a array <<< "$line"
            completion_target="${array[1]}"
            # using eval to avoid apostrophe
            completion_dir="$(eval echo ${array[2]})"
            completion_pattern="${array[3]}"
            _completion_generate "$completion_target" "$completion_dir" "$completion_pattern"
        done < <(s -f $item _completion_register_generate)
    done < <(find "$MY_SH_MODULE" -type f -iname *.bash)
}

