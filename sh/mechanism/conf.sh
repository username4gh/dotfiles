#! /usr/bin/env bash

_conf_read() {
    # $1 --> variant name
    if [[ "$#" == 1 ]];then
        if [[ -f "$MY_SH/.conf" ]];then
            echo $(cat "$MY_SH/.conf" | s -i "$1" | s -o '(?<=\]).*?(?=$)')
        fi
    else
        echo "Usage: _conf_read key"
    fi
}

_conf_write() {
    # $1 --> variant name
    # $2 --> variant value
    if [[ "$#" == 2 ]];then
        if [[ -f "$MY_SH/.conf" ]];then
            # delete old record
            sed -e "/\[$1\]/d" -i.tmp $MY_SH/.conf
        fi
        echo "[$1]$2" >> $MY_SH/.conf
    else
        echo "Usage: _conf_write key value"
    fi
}
