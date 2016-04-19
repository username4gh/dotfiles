#! /usr/bin/env sh

if [[ $(whoami) != root ]];then
    _my_load_sh_files $MY_SH_MODULE/backup src
    export MY_BACKUP_DIR=$MY_REPO/my-backup-dir
fi
