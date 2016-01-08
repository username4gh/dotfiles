#! /usr/bin/env bash
_scala_latest_url() {
    local latest_version_code
    latest_version_code=$(curl -s http://scala-lang.org/download/ | ack -o '(?<=Download\ Scala\ ).*?(?=\ binaries\ for\ your\ system)')
    _module_config_write 'scala' 'scala'
    echo "http://downloads.typesafe.com/scala/$latest_version_code/scala-$latest_version_code.tgz"
}

export PATH="$MY_BIN/scala-$(_module_config_read 'scala' 'scala')/bin:$PATH"
