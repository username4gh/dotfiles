#! /usr/bin/env bash

_android_ant_latest_url() {
    local latest_version_code
    latest_version_code=$(curl -s http://ant.apache.org/bindownload.cgi| s -o '(?<=Apache\ Ant\ ).*?(?=\ is\ the\ best\ available\ version)')
    _conf_write 'ant' $latest_version_code
    echo "http://mirrors.noc.im/apache//ant/binaries/apache-ant-$latest_version_code-bin.tar.gz"
}

export PATH="$MY_BIN/apache-ant-$(_conf_read 'ant')/bin:$PATH"
