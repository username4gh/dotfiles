#! /bin/bash

export PATH="$MY_BIN/jd_gui:$PATH"

# android-related
export ANDROID_HOME="$MY_BIN/sdk"
export ANDROID_SDK="$MY_BIN/sdk"
export ANDROID_NDK="$MY_BIN/android-ndk-r10e"

export PATH="$ANDROID_NDK:$PATH"
export PATH="$ANDROID_SDK/tools:$PATH"
export PATH="$ANDROID_SDK/build-tools/23.0.2:$PATH"
export PATH="$ANDROID_SDK/platform-tools:$PATH"

_android_cscope() {
    local ndk_version

    ndk_version=$(_conf_read ANDROID_NDK_VERSION)

    if [[ -d "$ANDROID_NDK" ]];then
        if [[ ! -d "$HOME/cscope_db" ]]; then
            mkdir -vp "$HOME/cscope_db/ndk/$ndk_version"
            echo "mkdir cscope_db/ndk/$ndk_version"
        fi

        (find "$ANDROID_NDK/platforms/$ndk_version/arch-arm/usr/include/" -name '*.[ch]' > "$HOME/cscope_db/ndk/$ndk_version/cscope.files" \
            && cd "$HOME/cscope_db/ndk/$ndk_version" \
            && cscope -bvq)
    fi
}
export CSCOPE_DB="$HOME/cscope_db/ndk/$(_conf_read ANDROID_NDK_VERSION)/cscope.out"
