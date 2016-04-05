#! /usr/bin/env sh

#Description clean up gitlab backups, only save the newest one

_cleanup_gitlab_backups() {
    echo "GITLAB_BACKUPS_DIR=/var/opt/gitlab/backups"

    if [[ $(find /var/opt/gitlab/backups -type f | wc -l) -gt 1 ]];then
        find /var/opt/gitlab/backups -name "*.tar" | s -v "$(ls -rt /var/opt/gitlab/backups | tail -1)" | xargs rm -v
    else
        echo "only one backup left!"
    fi
}
