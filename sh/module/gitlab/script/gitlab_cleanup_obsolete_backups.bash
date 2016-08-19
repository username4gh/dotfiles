#! /usr/bin/env bash

GITLAB_BACKUPS_DIR=/var/opt/gitlab/backups

echo "GITLAB_BACKUPS_DIR=$GITLAB_BACKUPS_DIR"

if [[ $(find "$GITLAB_BACKUPS_DIR" -type f | wc -l) -gt 1 ]];then
    find "$GITLAB_BACKUPS_DIR" -name "*.tar" | s -v "$(ls -rt "$GITLAB_BACKUPS_DIR" | tail -1)" | xargs rm -v
else
    echo "only one backup left!"
fi

uset GITLAB_BACKUPS_DIR
