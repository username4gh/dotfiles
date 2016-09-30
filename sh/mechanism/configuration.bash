#! /usr/bin/env bash

_conf_list() {
    if [[ -f "$MY_SH/.conf" ]];then
        cat "$MY_SH/.conf"
    fi
}

_conf_clear() {
    if [[ -f "$MY_SH/.conf" ]];then
        rm "$MY_SH/.conf"
    fi
}

# here I make the _conf_read case-sensitive & only read the key which matchs the whole word
_conf_read() {
    # $1 --> variant name
    if [[ "$#" == 1 ]];then
        if [[ -f "$MY_SH/.conf" ]];then
            echo $(s -f "$MY_SH/.conf" -w "$1" | s -o '(?<=]).*?(?=$)')
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
            # delete old record, we need the gnu sed to achieve it
            sed -e "/\[$1\]/d" -i.tmp $MY_SH/.conf
        fi
        echo "[$1]$2" >> $MY_SH/.conf
    else
        echo "Usage: _conf_write key value"
    fi
}
