#! /usr/bin/env bash

export MY_SH_COMPLETIONS="$MY_DOTFILES/completions"

_completion_read() {
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        # $1 --> variant name
        if [[ "$#" -eq 1 ]];then
            if [[ -f "$MY_SH_COMPLETIONS/$1.completion" ]];then
                cat "$MY_SH_COMPLETIONS/$1.completion"
            fi
        else
            echo "Usage: _completion_read completion_file_name"
        fi
    fi
}

_completion_write() {
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        # $1 --> variant name
        # $2 --> variant value
        if [[ ! -d "$MY_SH_COMPLETIONS" ]];then
            mkdir -p "$MY_SH_COMPLETIONS"
        fi

        if [[ "$#" -gt 1 ]];then
            local size=$#
            local max_index=$((size-1))
            local args=($@)

            local name
            for ((i = 0; i < max_index; i++))
            do
                if [[ $i -eq $((size-2)) ]];then
                    name+=${args[$i]}
                else
                    name+=${args[$i]}_
                fi
            done

            if [[ -f "$MY_SH_COMPLETIONS/$name.completion" ]];then
                # delete old record, we need the gnu sed to achieve it
                sed -e "/${args[$max_index]}/d" -i.tmp "$MY_SH_COMPLETIONS/$name.completion"
            fi

            echo "${args[$max_index]}" >> "$MY_SH_COMPLETIONS/$name.completion"
        else
            echo "Usage: _completion_write parent child grandchild"
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
        done < <(find "$2" -maxdepth 1 -type f | pythongrep "$3")
    fi
}

_annotation_completion_write () {
    # like java-annotation, i use this to annotate certain lines in bash file, in
    # order to process them later
    return
}

_annotation_completion_generate() {
    # like java-annotation, i use this to annotate certain lines in bash file, in
    # order to process them later
    if [[ "$#" -eq 3 ]];then
        return
    else
        echo "#@"
    fi
}

_completion_complete() {
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        local cur="${COMP_WORDS[COMP_CWORD]}"

        local size=$COMP_CWORD
        local max_index=$((size-1))
        local args=($COMP_LINE)

        local name
        for ((i = 0; i < size; i++))
        do
            if [[ $i -eq $max_index ]];then
                name+=${args[$i]}
            else
                name+=${args[$i]}_
            fi
        done

        local completion_args="$(_completion_read $name)"

        if [[ "${#completion_args}" == 0 ]];then
            compopt -o default
        else
            compopt +o default
            COMPREPLY=( $(compgen -W "${completion_args}" -- ${cur}) )
        fi
    fi
}

_completion_setup() {
    # $1 target command
    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        complete -F _completion_complete $1
    fi
}

_completion_process() {
    # deal with _annotation_completion_write
    while IFS= read -r line
    do
        completion_args=$(echo "$line" | cut -d ' ' -f2-)
        _completion_write $completion_args
    done < <(pythongrep -f $1 '^_annotation_completion_write[a-zA-Z0-9_\s]+[^(){}]')

    # deal with _annotation_completion_generate
    while IFS= read -r line
    do
        IFS=' ' read -r -a array <<< "$line"
        completion_target="${array[1]}"
        # using eval to avoid apostrophe
        completion_dir="$(eval echo ${array[2]})"
        completion_pattern="${array[3]}"
        _completion_generate "$completion_target" "$completion_dir" "$completion_pattern"
    done < <(pythongrep -f $1 '^_annotation_completion_generate[a-zA-Z0-9_\s]+[^(){}]')
}

completion_generate() {
    if [[ ! -f "$MY_SH/cache.bash" ]];then
        echo "this command should only work with the cache.bash"
        #while IFS= read -r file
        #do
        #    _completion_process "$file"
        #    # filtered out some irrelevant files to boost performance
        #done < <(find "$MY_SH_MODULE" -type f -iname "*.bash" | pythongrep 'src')
    else
        _completion_process "$MY_SH/cache.bash"
    fi
}

