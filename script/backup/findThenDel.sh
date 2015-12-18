#! /bin/bash -x
eval find . -type f -name "$1" -exec rm -rvf {} \\\;
