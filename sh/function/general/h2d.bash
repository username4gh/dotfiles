#! /usr/bin/env bash

h2d() {
    echo "ibase=16; "$1"" | bc
}