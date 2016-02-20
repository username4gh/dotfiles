_android_gradle_latest_url() {
    local latest_version_code
    latest_version_code=$(curl -s http://gradle.org/gradle-download/ | s -o '(?<=\<h1\>Download\ Gradle\ ).*?(?=\<\/h1\>)')
    _conf_write 'gradle' $latest_version_code
    echo "https://services.gradle.org/distributions/gradle-$latest_version_code-all.zip"
}

export PATH="$MY_BIN/gradle-2.9/bin:$PATH"
