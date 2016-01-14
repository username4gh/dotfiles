_myvi_compile_YouCompileMe() {
    if [[ "$(_check_os)" == 'Darwin' ]];then
        echo "check https://github.com/Valloric/YouCompleteMe/issues/8"
        if [[ "$(port select --list python | ack active | ack -o '(?<=^).*?(?=\()')" == 'none' ]];then
            echo "please do 'sudo port select --set python python27'";
            return
        fi

        if [[ "$(port select --list gcc | ack active | ack -o '(?<=^).*?(?=\()')" == 'none' ]];then
            echo "With Macports, we cannot use built-in C_COMPILER of osx, so we unset PATH, and then we need to specify gcc" 
            return
        fi

        (cd "$HOME/.vim/bundle/YouCompleteMe";
        unset PATH;
        export EXTRA_CMAKE_ARGS='-DPYTHON_EXECUTABLE=/opt/local/bin/python'
        export PATH="/opt/local/bin:$PATH";
        export PATH="/opt/local/sbin:$PATH";
        export PATH="/opt/local/libexec/gnubin:$PATH";
        export PATH="/bin:$PATH"
        echo $PATH
        python ./install.py)
    fi
}

_myvi_init() {
    if [[ ! -h "$HOME/.vimrc" ]];then
        if [[ -f "$HOME/.vimrc" ]];then
            rm "$HOME/.vimrc"
        fi

        ln -s "$MY_REPO/my-i3/.vimrc" "$HOME/.vimrc"
    fi
}

