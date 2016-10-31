#! /usr/bin/env bash

latest_version_code=$(curl https://www.xquartz.org/ | s 'https://dl.bintray.com/xquartz/downloads' | s -o '(?<=href=\").*?(?=\"\>\<span)')
echo "$latest_version_code"
unset latest_version_code