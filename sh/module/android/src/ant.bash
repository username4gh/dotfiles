#! /usr/bin/env bash

_android_ant_latest_url() {
    local latest_version_code
    latest_version_code=$(curl -s https://ant.apache.org/bindownload.cgi| s -o '(?<=Apache\ Ant\ ).*?(?=\ is\ the\ best\ available\ version)')
    _conf_write 'ANT_LATEST_VERSION' $latest_version_code
    echo "https://www.apache.org/dist/ant/binaries/apache-ant-$latest_version_code-bin.tar.gz"
}

export PATH="$(_autodetect_bin 'apache-ant-.*')/bin:$PATH"
