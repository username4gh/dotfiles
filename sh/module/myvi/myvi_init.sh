_myvi_compile_YouCompileMe() {
    if [[ "$(port select --list python | ack active | ack -o '(?<=^).*?(?=\()')" == 'none' ]];then
        echo "please do 'sudo port select --set python python27'";
    else
        (cd "$HOME/.vim/bundle/YouCompleteMe";
        unset PATH;
        export PATH="/opt/local/bin:$PATH";
        export PATH="/opt/local/sbin:$PATH";
        export PATH="/opt/local/libexec/gnubin:$PATH";
        python ./install.py)
    fi
}

_myvi_init() {
    echo "$0";
    if [[ ! -h "$HOME/.vimrc" ]];then
        if [[ -f "$HOME/.vimrc" ]];then
            rm "$HOME/.vimrc"
        fi

        ln -s "$MY_REPO/my-i3/.vimrc" "$HOME/.vimrc"
    fi
}

