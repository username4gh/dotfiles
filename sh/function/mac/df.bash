#! /usr/bin/env bash

if [[ -f "/opt/local/libexec/gnubin/df" ]];then
    df(){
        if [[ "$#" == 0 ]];then
            (export LC_ALL="en_US.UTF-8"; /opt/local/libexec/gnubin/df)
        else
            (export LC_ALL="en_US.UTF-8"; /opt/local/libexec/gnubin/df "$@")
        fi
    }
fi
