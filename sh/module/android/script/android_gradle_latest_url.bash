#! /usr/bin/env bash

latest_version_code=$(curl -s https://gradle.org/gradle-download/ | s -o '(?<=\<h1\>Download\ Gradle\ ).*?(?=\<\/h1\>)')
echo "https://services.gradle.org/distributions/gradle-$latest_version_code-all.zip"
unset latest_version_code
