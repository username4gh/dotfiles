#! /usr/bin/env bash

latest_version_code=$(curl -s https://ant.apache.org/bindownload.cgi| s -o '(?<=Apache\ Ant\ ).*?(?=\ is\ the\ best\ available\ version)')
echo "https://www.apache.org/dist/ant/binaries/apache-ant-$latest_version_code-bin.tar.gz"
unset latest_version_code
