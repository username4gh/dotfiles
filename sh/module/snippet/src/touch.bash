#! /usr/bin/env bash

_touch() {
    if [[ "$#" == 1 ]];then
        local path=$(_file_path $1)
        local full_name=$(_file_name $1)
        local name=$(_file_name_noext $1)

        if [[ "${full_name}" == "${name}" ]]; then
            command touch "$path/$name"
            return
        else
            local ext=$(_file_ext $1)

            if [[ -f "$MY_SH_MODULE/snippet/snippets/snippet.$ext" ]];then
                cp "$MY_SH_MODULE/snippet/snippets/snippet.$ext" "$path/$name.$ext"
            else
                command touch "$path/$name.$ext"
            fi

            if [[ "$ext" == 'java' ]];then
                gsed -i "s/public\ class\ Main/public\ class $name/g" "$path/$name.$ext"
            fi
        fi

        unset path
        unset name
        unset ext
    else
        echo "Usage: touch full_filename"
    fi
}

alias touch="_touch"
