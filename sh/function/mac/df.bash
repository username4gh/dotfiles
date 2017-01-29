#! /usr/bin/env bash

if [[  "$(uname)" == 'Darwin' ]];then
    df(){
        if [[ "$#" == 0 ]];then
            (export LC_ALL="en_US.UTF-8"; gdf)
        else
            (export LC_ALL="en_US.UTF-8"; gdf "$@")
        fi
    }
fi
