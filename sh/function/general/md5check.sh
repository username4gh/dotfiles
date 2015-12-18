#! /usr/bin/env bash

md5check() { 
    md5sum "$1" | grep "$2";
}