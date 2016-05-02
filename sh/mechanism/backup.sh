#! /usr/bin/env sh

export MY_BACKUP_DIR=$MY_REPO/my-backup

_backup_get_dest_dir() {
    if [[ ! -d "$MY_BACKUP_DIR" ]];then
        echo 'please enter the backup repo git address'
        read backup_git_address
        git clone "$backup_git_address" "$MY_BACKUP_DIR"
    fi
    timestamp=$(_timestamp_ymd)
    if [[ ! -d "$MY_BACKUP_DIR/$timestamp" ]];then
        mkdir -p "$MY_BACKUP_DIR/$timestamp"
    fi
    echo $MY_BACKUP_DIR/$timestamp
}
