#! /usr/bin/env bash

url="http://ghaffarian.net/downloads/Java/$(curl -s http://ghaffarian.net/downloads/Java/ | s -o "(?<=<a\ href=\").*?(?=\">)" | s x64.tar.gz | sort | uniq | s 7u)"
echo $url
unset url