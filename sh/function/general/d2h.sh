#! /usr/bin/env bash

#Description digit to hex

d2h() {
    echo "obase=16; "$1"" | bc
}
