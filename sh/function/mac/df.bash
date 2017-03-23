#! /usr/bin/env bash

if [[  "$(uname)" == 'Darwin' ]];then
    df(){
        (export LC_ALL="en_US.UTF-8"; gdf "$@")
    }
fi
