#! /usr/bin/env bash

_ack_latest_url() {
    local latest_version_code
    latest_version_code=$(curl -s http://beyondgrep.com/install/ | grep -Po '(?<=The\ current\ stable\ version\ of\ ack\ is\ version\ ).*?(?=,\ released)')
    echo "http://beyondgrep.com/ack-$latest_version_code-single-file"
}

if [[ ! -f "$HOME/bin/ack" ]];then
    curl -s "$_ack_latest_url" > ~/bin/ack && test -z ~/bin/ack || chmod 0755 ~/bin/ack 
fi
