#! /usr/bin/env bash

if [[ "$(uname -s)" == 'Darwin' ]];then
    echo "check https://github.com/Valloric/YouCompleteMe/issues/8"
    if [[ "$(port select --list python | s active | s -o '(?<=^).*?(?=\()')" == 'none' ]];then
        echo "With Macports, please do 'sudo port select --set python python27'";
        exit
    fi

    #if [[ "$(port select --list gcc | s active | s -o '(?<=^).*?(?=\()')" == 'none' ]];then
    #    echo "With Macports, I use the gcc49 as CMAKE_C_COMPILER & CMAKE_CXX_COMPILER"
    #    exit
    #fi

    if [[ ! -f "/opt/local/bin/cmake" ]];then
        echo "With Macports, I use the cmake as the CMAKE_MAKE_PROGRAM"
    fi

    # https://github.com/Valloric/YouCompleteMe/issues/679
    (cd "$HOME/.vim/bundle/YouCompleteMe";
    unset PATH;

    export CMAKE_MAKE_PROGRAM='/opt/local/bin/cmake'
    
    # in order to enable --clang-completer, I use the `port install llvm-3.8`, and then un-comment below too line
    export PATH_TO_LLVM_ROOT='/opt/local/libexec/llvm-3.9'
    export EXTRA_CMAKE_ARGS="-DPYTHON_EXECUTABLE=/opt/local/bin/python, -DPATH_TO_LLVM_ROOT=$PATH_TO_LLVM_ROOT"

    export CMAKE_C_COMPILER="/opt/local/bin/clang"
    export CMAKE_CXX_COMPILER="/opt/local/bin/clang"

    export PATH="/opt/local/bin:$PATH";
    export PATH="/opt/local/sbin:$PATH";
    export PATH="/opt/local/libexec/gnubin:$PATH";
    export PATH="/bin:$PATH"
    echo $PATH
    echo $PATH_TO_LLVM_ROOT
    #python ./install.py)
    python ./install.py --clang-completer)
fi
