#! /usr/bin/env bash


if [[ "$#" == 2 ]];then
    keytool -genkey -v -keystore "$1" -alias "$2" -keyalg RSA -keysize 2048 -validity 10000
else
    echo "Usage: command key.keystore alias_name"
fi
