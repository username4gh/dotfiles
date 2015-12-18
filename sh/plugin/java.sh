#! /usr/bin/env bash
if [[ "$(_check_os)" == "Linux" ]];then
	export JDK_PATH="$HOME/bin/jdk1.7.0_80"
	export JAVA_HOME="$HOME/bin/jdk1.7.0_80"
	export PATH="$JDK_PATH/bin:$PATH"
fi