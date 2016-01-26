#! /bin/bash

_binutils_latest() {
    local BINUTILS
    BINUTILS=$(curl -s http://ftp.gnu.org/gnu/binutils/ | s 'binutils-.*\.tar\.gz' | s -v 'patch' | s -o '(?<=gz\"\>).*(?=\.tar\.gz\<\/a)' | sort -rV | head -1)
    echo "http://ftp.gnu.org/gnu/binutils/$BINUTILS.tar.gz"
}

# ./configure --enable-targets=aarch64-linux-gnu,aarch64_be-linux-gnu,alpha-linux-gnu,hppa-linux-gnu,arm-linux-gnueabi,i686-linux-gnu,m32r-linux-gnu,m68k-linux-gnu,m68k-rtems,mips-linux-gnu,mipsel-linux-gnu,mips64-linux-gnu,mips64el-linux-gnu,powerpc-linux-gnu,powerpc64-linux-gnu,powerpc64le-linux-gnu,s390x-linux-gnu,sh-linux-gnu,sh64-linux-gnu,sparc-linux-gnu,sparc64-linux-gnu,x86_64-linux-gnu,x86_64-linux-gnux32,x86_64-pep

_binutils_nm(){
    local binutils

    binutils=$(find ~/bin -maxdepth 1 -type d  | s 'binutils-.*')

    if [[ "$#" == 0 ]];then
        (export PATH="$MY_BIN/binutils-2.25/binutils:$PATH"; $binutils/binutils/nm-new)
    else
        (export PATH="$MY_BIN/binutils-2.25/binutils:$PATH"; $binutils/binutils/nm-new "$@")
    fi
}

_binutils_readelf(){
    local binutils

    binutils=$(find ~/bin -maxdepth 1 -type d  | s 'binutils-.*')

    if [[ "$#" == 0 ]];then
        (export PATH="$MY_BIN/binutils-2.25/binutils:$PATH"; $binutils/binutils/readelf)
    else
        (export PATH="$MY_BIN/binutils-2.25/binutils:$PATH"; $binutils/binutils/readelf "$@")
    fi
}
