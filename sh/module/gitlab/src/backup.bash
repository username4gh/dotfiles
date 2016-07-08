#! /usr/bin/env bash

#Description clean up gitlab backups, only save the newest one
_gitlab_cleanup_obsolete_backups() {
    local GITLAB_BACKUPS_DIR=/var/opt/gitlab/backups

    echo "GITLAB_BACKUPS_DIR=$GITLAB_BACKUPS_DIR"

    if [[ $(find "$GITLAB_BACKUPS_DIR" -type f | wc -l) -gt 1 ]];then
        find "$GITLAB_BACKUPS_DIR" -name "*.tar" | s -v "$(ls -rt "$GITLAB_BACKUPS_DIR" | tail -1)" | xargs rm -v
    else
        echo "only one backup left!"
    fi
}

_gitlab_list_all_backups() {
    local GITLAB_BACKUPS_DIR=/var/opt/gitlab/backups
    
    echo "GITLAB_BACKUPS_DIR=$GITLAB_BACKUPS_DIR"

    find "$GITLAB_BACKUPS_DIR" -name "*.tar"
}
