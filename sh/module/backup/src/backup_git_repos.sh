#! /usr/bin/env sh

_backup_git_repos() {
    # first I register all the git repos to the mrconfig
    my_repos_register_all

    # then I just copy the updated '.mrconfig' to the backup dir
    if [[ ! -d "$MY_BACKUP_DIR" ]];then
        echo 'please enter the backup repo git address'
        read backup_git_address
        git clone "$backup_git_address" "$MY_BACKUP_DIR"
    fi
    cp "$HOME/.mrconfig" "$MY_BACKUP_DIR/$(_timestamp_ymd)/"
}
