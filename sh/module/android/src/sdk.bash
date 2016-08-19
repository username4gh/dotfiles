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
    local ndk_include

    ndk_version=$(_conf_read ANDROID_NDK_VERSION)
    ndk_include=$ANDROID_NDK/platforms/$ndk_version/arch-arm/usr/include/

    if [[ "$ndk_version" != '' ]];then
        if [[ -d "$ANDROID_NDK" ]];then
            if [[ ! -d "$HOME/cscope_db" ]]; then
                mkdir -vp "$HOME/cscope_db/ndk/$ndk_version"
                echo "mkdir cscope_db/ndk/$ndk_version"
            fi

            (find "$ndk_include" -name '*.aidl' -o -name '*.cc' -o -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.py' > "$HOME/cscope_db/ndk/$ndk_version/cscope.files" \
                && cd "$HOME/cscope_db/ndk/$ndk_version" \
                && cscope -bvq \
                && cd "$ndk_include" \
                && ctags -R --links=no --tag-relative=yes --exclude=.svn --exclude=.git --c++-kinds=+p --fields=+iaS --extra=+q -f "$HOME/cscope_db/ndk/$ndk_version/tags")
        fi
    else
        echo 'plz set ANDROID_NDK_VERSION first'
    fi

    unset ndk_version
    unset ndk_include
}

if [[ "$(_conf_read ANDROID_NDK_VERSION)" == '' ]];then
    echo 'plz set ANDROID_NDK_VERSION first, using _conf_write'
else
    export NDK_INCLUDE_CTAGS_DB="$HOME/cscope_db/ndk/$(_conf_read ANDROID_NDK_VERSION)/tags"
    export NDK_INCLUDE_CSCOPE_DB="$HOME/cscope_db/ndk/$(_conf_read ANDROID_NDK_VERSION)/cscope.out"
fi
