#! /usr/bin/env bash

export PATH="$MY_BIN/jd_gui:$PATH"

# android-related
export ANDROID_HOME="$MY_BIN/sdk"
export ANDROID_SDK="$MY_BIN/sdk"
export ANDROID_NDK="$ANDROID_SDK/ndk-bundle"

export PATH="$ANDROID_NDK:$PATH"
export PATH="$ANDROID_SDK/tools:$PATH"
export PATH="$ANDROID_SDK/build-tools/23.0.2:$PATH"
export PATH="$ANDROID_SDK/platform-tools:$PATH"

_android_cscope() {
    local ndk_version

    ndk_version=$(_conf_read ANDROID_NDK_VERSION)

    if [[ "$ndk_version" != '' ]];then
        if [[ -d "$ANDROID_NDK" ]];then
            if [[ ! -d "$HOME/cscope_db" ]]; then
                mkdir -vp "$HOME/cscope_db/ndk/$ndk_version"
                echo "mkdir cscope_db/ndk/$ndk_version"
            fi

            (find "$ANDROID_NDK/platforms/$ndk_version/arch-arm/usr/include/" -name '*.aidl' -o -name '*.cc' -o -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.py' > "$HOME/cscope_db/ndk/$ndk_version/cscope.files" \
                && cd "$HOME/cscope_db/ndk/$ndk_version" \
                && cscope -bvq)
        fi
    else
        echo 'plz set ANDROID_NDK_VERSION first'
    fi

    unset ndk_version
}

if [[ "$(_conf_read ANDROID_NDK_VERSION)" == '' ]];then
    echo 'plz set ANDROID_NDK_VERSION first, using _conf_write'
else
    export CSCOPE_DB="$HOME/cscope_db/ndk/$(_conf_read ANDROID_NDK_VERSION)/cscope.out"
fi

_android_sign() {
    # http://developer.android.com/intl/ja/tools/publishing/app-signing.html
    local keystore=$1
    local apk=$2
    local alias_name=$3
    jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $keystore $apk $alias_name
}
