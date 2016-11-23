#! /usr/bin/env bash

# https://www.chromium.org/user-experience/user-data-directory
_backup_chrome_browsing_history() {
    if [[ "$(_check_os)" == Darwin ]];then
        local HISTORY_FILE="$(find /Users/$USER/Library/Application\ Support -mindepth 1 -maxdepth 1 -type d -name "*Google*")"
        (cd "$HISTORY_FILE"; cp -vr $(find ./Chrome/ -iname History) "$1")
    fi
}

if [[ "$(_check_os)" == Darwin ]];then
    if [[ -d "$MY_BACKUP_DIR" ]];then
        if [[ "$(ymdGapInDays "$(ls $MY_BACKUP_DIR | tail -1)")" -gt 7 ]];then
            _sh_log "${BASH_SOURCE[0]}" 'backup chrome browsing history'
            _backup_chrome_browsing_history "$(_backup_get_dest_dir)/"
        fi
    else
        _sh_log "${BASH_SOURCE[0]}" 'MY_BACKUP_DIR does not exist!!!'
    fi
fi
