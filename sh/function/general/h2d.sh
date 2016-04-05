#! /usr/bin/env sh

h2d() {
    echo "ibase=16; "$1"" | bc
}