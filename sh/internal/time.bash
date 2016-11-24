#! /usr/bin/env bash

_timestamp_ymd() {
    echo "$(date +%Y-%m-%d)"
}

_timestamp_hms() {
    echo "$(date +%H-%M-%S)"
}

_timestamp() {
    echo "$(date +%Y-%m-%d-%H-%M-%S)"
}
