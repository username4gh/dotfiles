#! /usr/bin/env bash

_backup_chrome_browsing_history() {
    if [[ "$(_check_os)" == Darwin ]];then
        local HISTORY_FILE="$(find /Users/$USER/Library/Application\ Support -mindepth 1 -maxdepth 1 -type -d -name "*Google*")"
        echo $HISTORY_FILE
        (cd "$HISTORY_FILE"; echo "$pwd"; cp -r ./Chrome "$1")
    fi
}

if [[ "$(_check_os)" == Darwin ]];then
    if [[ -d "$MY_BACKUP_DIR" ]];then
        if [[ "$(ymdGapInDays "$(ls $MY_BACKUP_DIR | tail -1)")" -gt 7 ]];then
            echo "backup chrome browsing history"
            _backup_chrome_browsing_history "$(_backup_get_dest_dir)/"
        fi
    else
        echo "MY_BACKUP_DIR does not exist!!!"
    fi
fi
