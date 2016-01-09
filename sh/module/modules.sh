#! /usr/bin/env bash

_modules_init() {

    local modules
    local module

    modules=(android c cabal enchancd flatbuffers fpp go history java macports-tools myfzf myrepos mytranslate myvi nvm prompt python rvm scala sdkman vundle xkcdpass z)

    for module in $modules;
    do
        _myload_sh_files $MY_SH_MODULE $module;
    done
}

_modules_init
