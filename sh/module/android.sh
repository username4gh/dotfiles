#! /bin/bash
export PATH="$HOME/bin/apache-ant-1.9.6/bin:$PATH"
export PATH="$HOME/bin/gradle-2.9/bin:$PATH"
export PATH="$HOME/bin/apache-maven-3.3.3/bin:$PATH"
export PATH="$HOME/bin/jd_gui:$PATH"
export PATH="$HOME/bin/dex2jar-2.0:$PATH"

# android-related
export ANDROID_HOME="$HOME/bin/sdk"
export ANDROID_SDK="$HOME/bin/sdk"
export ANDROID_NDK="$HOME/bin/android-ndk-r10e"
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

_android_apktool_jar(){
    local url
    url="https://bitbucket.org$(curl -s https://bitbucket.org/iBotPeaches/apktool/downloads | grep -Po "(?<=<a\ class=\"execute\"\ href=\").*?(?=\">)" | head -1)"
    echo $url
}

# apktool
if [[ ! -f "$HOME/bin/apktool" ]];then
    wget -c https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/osx/apktool -O "$HOME/bin/apktool"
    wget -c "$(_android_apktool_jar)" -O "$HOME/bin/apktool.jar"
fi
