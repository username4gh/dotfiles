#! /usr/bin/env bash

export MY_MODULE_CONFIG=$MY_SH/module/conf.d

_module_config_read() {
    # $1 --> module name
    # $2 --> variant name
    if [[ -f "$MY_MODULE_CONFIG/$1.conf" ]];then
        echo $(cat "$MY_MODULE_CONFIG/$1.conf" | grep -i "$2" | grep -Po '(?<=\]).*?(?=$)')
    fi
}

_module_config_write() {
    # $1 --> module name
    # $2 --> variant name
    # $3 --> variant value
    if [[ ! -d "$MY_MODULE_CONFIG" ]];then
        mkdir -p "$MY_MODULE_CONFIG"
    fi

    if [[ -f "$MY_MODULE_CONFIG/$1.conf" ]];then
        # delete old record
        sed -i "/\[$2\]/d" $MY_MODULE_CONFIG/$1.conf
    fi
    echo "[$2]$3" >> $MY_MODULE_CONFIG/$1.conf
}
