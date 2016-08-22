#! /usr/bin/env bash

# http://developer.android.com/intl/ja/tools/publishing/app-signing.html
local keystore=$1
local apk=$2
local alias_name=$3
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $keystore $apk $alias_name
