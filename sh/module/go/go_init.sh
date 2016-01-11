_go_init() {
    if [[ ! -d "$MY_BIN/go" ]]; then
        mkdir -p "$MY_BIN/go"
    fi

    if [[ ! -d "$HOME/go" ]];then
        mkdir -p "$HOME/go"
    fi

    local fileUrl
    local fileName

    if [[ "$(_check_command go)" == 0 ]];then
        echo "beginning go init"
        if [[ "$(_check_os)" == "Darwin" ]];then
            fileUrl=$(_go_latest_url_mac)
        elif [[ "$(_check_os)" == "Linux" ]]; then
            fileUrl=$(_go_latest_url_linux)
        fi

        fileName=$(_file_name_from_url "$fileUrl")

        (echo $fileUrl

        echo $fileName

        curl -L -C - "$fileUrl" -o "$MY_BIN/$fileName" && cd $MY_BIN && tar -xf $fileName)
    fi
}
