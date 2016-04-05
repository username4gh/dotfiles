#! /usr/bin/env sh

md5check() { 
    md5sum "$1" | s "$2";
}
