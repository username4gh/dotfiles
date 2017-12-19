#! /usr/bin/env bash

_java_bin_init() {
    local fileUrl
    local fileName

    if ! _is_command_exist java;then
        echo "beginning java init"
        if _is_darwin;then
            echo "Go 'http://www.oracle.com/technetwork/java/javase/downloads/index.html' to download !"
        fi

        if _is_linux; then
            fileUrl=$(_java_8_url_linux)
        fi

        fileName=$(_file_name_from_uri "$fileUrl")

        (echo $fileUrl

        echo $fileName

        curl -L -C - "$fileUrl" -o "$MY_BIN/$fileName" && cd $MY_BIN && tar -xf $fileName)
    fi
}

_java_init() {
    _java_bin_init
}

if _is_linux;then
    export JDK_PATH="$(_autodetect_bin "jdk1\..*")"
    if [[ "${#JDK_PATH}" -eq 0 ]];then
        _sh_log "${BASH_SOURCE[0]}" "jdk has not been installed yet"
    else
        export JAVA_HOME="$JDK_PATH"
        export PATH="$JDK_PATH/bin:$PATH"
    fi
fi

if _is_darwin;then
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/$(ls /Library/Java/JavaVirtualMachines/ | head -1)/Contents/Home"
    export JDK_PATH="$JDK_PATH"
fi
