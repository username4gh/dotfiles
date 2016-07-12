#! /usr/bin/env bash

_android_gradle_latest_version_url() {
    local latest_version_code
    latest_version_code=$(curl -s https://gradle.org/gradle-download/ | s -o '(?<=\<h1\>Download\ Gradle\ ).*?(?=\<\/h1\>)')
    _conf_write 'GRADLE_LATEST_VERSION' $latest_version_code
    echo "https://services.gradle.org/distributions/gradle-$latest_version_code-all.zip"
}

export PATH="$(_autodetect_bin 'gradle-.*')/bin:$PATH"
