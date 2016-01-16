_android_gradle_latest_url() {
    local latest_version_code
    latest_version_code=$(curl -s http://gradle.org/gradle-download/ | s -o '(?<=The\ latest\ release of\ Gradle\ is\ version).*?(?=,\ released\ on)' | ack -o '(?<=\<strong\>).*?(?=\<\/strong\>)')
    _module_config_write 'android' 'gradle' $latest_version_code
    echo "https://services.gradle.org/distributions/gradle-$latest_version_code-all.zip"
}

export PATH="$MY_BIN/gradle-2.9/bin:$PATH"
