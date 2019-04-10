#! /usr/bin/env bash

if ! _is_command_exist multimarkdown;then
    _sh_log "${BASH_SOURCE[0]}" "Need multimarkdown for previewing markdown"
fi

if _is_command_exist vim; then
    if _is_darwin;then
        if [[ "$MY_CURRENT_PACKAGE_MANAGER" == 'macports' ]];then
            # in order to keep pyenv and YouCompleteMe both work
            # https://github.com/Valloric/YouCompleteMe/issues/8
            alias vi='_vi'
        elif [[ "$MY_CURRENT_PACKAGE_MANAGER" == 'homebrew' ]];then
            if _is_command_exist 'nvim';then
                alias vi='_nvim'
            elif _is_command_exist 'vim';then
                alias vi='vim'
            fi
        fi
    fi
fi
