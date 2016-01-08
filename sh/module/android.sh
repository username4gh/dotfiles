#! /bin/bash
_android_ant_latest_url() {
    local latest_version_code
    latest_version_code=$(curl -s http://ant.apache.org/bindownload.cgi| ack -o '(?<=Apache\ Ant\ ).*?(?=\ is\ the\ best\ available\ version)')
    _module_config_write 'android' 'ant' $latest_version_code
    echo "http://mirrors.noc.im/apache//ant/binaries/apache-ant-$latest_version_code-bin.tar.gz"
}

_android_maven_latest_url(){
    local latest_version_code
    latest_version_code=$(curl -s http://maven.apache.org/download.cgi | ack -o '(?<=Apache\ Maven\ ).*?(?=\ is\ the\ latest\ release\ and\ recommended\ version\ for\ all\ users\.)')
    _module_config_write 'android' 'maven' $latest_version_code
    echo "http://mirrors.hust.edu.cn/apache/maven/maven-3/$latest_version_code/binaries/apache-maven-$latest_version_code-bin.tar.gz"
}

_android_gradle_latest_url() {
    local latest_version_code
    latest_version_code=$(curl -s http://gradle.org/gradle-download/ | ack -o '(?<=The\ latest\ release of\ Gradle\ is\ version).*?(?=,\ released\ on)' | ack -o '(?<=\<strong\>).*?(?=\<\/strong\>)')
    _module_config_write 'android' 'gradle' $latest_version_code
    echo "https://services.gradle.org/distributions/gradle-$latest_version_code-all.zip"
}

export PATH="$MY_BIN/apache-ant-$(_module_config_read 'android' 'ant')/bin:$PATH"
export PATH="$MY_BIN/apache-maven-3.3.3/bin:$PATH"
export PATH="$MY_BIN/gradle-2.9/bin:$PATH"
export PATH="$MY_BIN/jd_gui:$PATH"

# android-related
export ANDROID_HOME="$MY_BIN/sdk"
export ANDROID_SDK="$MY_BIN/sdk"
export ANDROID_NDK="$MY_BIN/android-ndk-r10e"
export PATH="$ANDROID_NDK:$PATH"
export PATH="$ANDROID_SDK/tools:$PATH"
export PATH="$ANDROID_SDK/build-tools/23.0.2:$PATH"
export PATH="$ANDROID_SDK/platform-tools:$PATH"

# cscope
if [[ -d "$ANDROID_NDK" ]];then
    if [[ ! -d "$HOME/cscope_db" ]]; then
        mkdir -vp "$HOME/cscope_db/ndk"
        echo "mkdir cscope_db/ndk"

        (find "$ANDROID_NDK/platforms/android-16/arch-arm/usr/include/" -name '*.[ch]' > "$HOME/cscope_db/ndk/cscope.files" \
            && cd "$HOME/cscope_db/ndk" \
            && cscope -bvq)
    fi
fi
export CSCOPE_DB="$HOME/cscope_db/ndk/cscope.out"

_android_apktool_jar_url(){
    local url
    url="https://bitbucket.org$(curl -s https://bitbucket.org/iBotPeaches/apktool/downloads | ack -o "(?<=<a\ class=\"execute\"\ href=\").*?(?=\">)" | head -1)"
    echo $url
}

_android_apktool() {
    if [[ ! -f "$MY_BIN/apktool" ]];then
        curl -C - https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/osx/apktool > "$MY_BIN/apktool"

    fi

    if [[ ! -f "$MY_BIN/apktool.jar" ]];then
        curl -L -C - "$(_android_apktool_jar_url)" > "$MY_BIN/apktool.jar"
    fi
}
