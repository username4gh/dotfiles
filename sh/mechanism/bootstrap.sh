#! /usr/bin/env bash

_bootstrap() {
    local method
    local result

    while IFS= read -r item;
    do
        method="_$(_file_name_noext $item)_init"
        result=$(ack -o "$method\(\)" $item)
        if [[ -n "$result" ]];then
            $method
        fi
    done < <(find "$MY_SH/module" -maxdepth 1 -name "*.sh")
}