#! /usr/bin/env bash

_macports_backup() {
    port installed > "$(_backup_get_dest_dir)/macports"
}
