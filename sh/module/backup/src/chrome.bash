#! /usr/bin/env bash

# https://www.chromium.org/user-experience/user-data-directory
_backup_chrome_browsing_history() {
    if [[ "$#" -eq 1 ]];then
        if _is_darwin;then
            local GOOGLE_CHROME_DIR="/Users/$USER/Library/Application Support/Google/Chrome/"
            # here i assume that i only use the default profile
            (cd "$GOOGLE_CHROME_DIR"; rsync --recursive --progress --verbose "$(find ./Default -iname History)" "$1")
        fi
    fi
}

if _is_darwin;then
    if [[ -d "$MY_BACKUP_DIR" ]];then
        if [[ "$(ymdGapInDays "$(ls $MY_BACKUP_DIR | tail -1)")" -gt 7 ]];then
            _sh_log "${BASH_SOURCE[0]}" 'backup chrome browsing history'
            chrome_backup_dest_dir="$(_backup_get_dest_dir)"
            _backup_chrome_browsing_history "$chrome_backup_dest_dir/" && (cd "$chrome_backup_dest_dir"; git add . && git commit -am save)
            unset chrome_backup_dest_dir
        fi
    else
        _sh_log "${BASH_SOURCE[0]}" '$MY_BACKUP_DIR does not exist!!!'
    fi
fi
