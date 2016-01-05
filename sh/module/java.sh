#! /usr/bin/env bash

_java_7_url_linux() {
	local url
	url="http://ghaffarian.net/downloads/Java/$(curl -s http://ghaffarian.net/downloads/Java/ | grep -Po "(?<=<a\ href=\").*?(?=\">)" | grep x64.tar.gz | uniq -d | grep 7u)"
	echo $url
}

_java_8_url_linux() {
	local url
	url="http://ghaffarian.net/downloads/Java/$(curl -s http://ghaffarian.net/downloads/Java/ | grep -Po "(?<=<a\ href=\").*?(?=\">)" | grep x64.tar.gz | uniq -d | grep 8u)"
	echo $url
}

if [[ "$(_check_os)" == "Linux" ]];then
	export JDK_PATH="$HOME/bin/jdk1.7.0_80"
	export JAVA_HOME="$HOME/bin/jdk1.7.0_80"
	export PATH="$JDK_PATH/bin:$PATH"
fi
