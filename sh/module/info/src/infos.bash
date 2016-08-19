#! /usr/bin/env bash

my_info() {
    cat "$MY_SH_MODULE/info/infos/$1.info"
}

_completion_register_generate my_info $MY_SH_MODULE/info/infos info

_completion_setup my_info
