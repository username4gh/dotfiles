#! /usr/bin/env sh

_macports_backup() {
    port installed > "$(_backup_get_dest_dir)/macports"
}
