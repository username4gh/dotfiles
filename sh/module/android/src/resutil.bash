#! /usr/bin/env bash

my_android_del_old() {
    find . -name "$1" -exec rm -rvf {} \;
}
