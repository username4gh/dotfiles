#! /usr/bin/env bash

GITLAB_BACKUPS_DIR=/var/opt/gitlab/backups

echo "GITLAB_BACKUPS_DIR=$GITLAB_BACKUPS_DIR"

find "$GITLAB_BACKUPS_DIR" -name "*.tar"

unset GITLAB_BACKUPS_DIR
