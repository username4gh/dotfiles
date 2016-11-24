#! /usr/bin/env bash

ANT_PATH=$(_autodetect_bin 'apache-ant-.*')
if [[ "${#ANT_PATH}" -eq 0 ]];then
    _sh_log "${BASH_SOURCE[0]}" "ant has not been installed yet"
else
    export PATH="$ANT_PATH/bin:$PATH"
fi
