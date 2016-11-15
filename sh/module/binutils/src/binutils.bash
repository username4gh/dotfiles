#! /usr/bin/env bash

_binutils_latest() {
    local BINUTILS
    BINUTILS=$(curl -s http://ftp.gnu.org/gnu/binutils/ | s 'binutils-.*\.tar\.gz' | s -v 'patch' | s -o '(?<=gz\"\>).*(?=\.tar\.gz\<\/a)' | sort -rV | head -1)
    echo "http://ftp.gnu.org/gnu/binutils/$BINUTILS.tar.gz"
}

# ./configure --enable-targets=aarch64-linux-gnu,aarch64_be-linux-gnu,alpha-linux-gnu,hppa-linux-gnu,arm-linux-gnueabi,i686-linux-gnu,m32r-linux-gnu,m68k-linux-gnu,m68k-rtems,mips-linux-gnu,mipsel-linux-gnu,mips64-linux-gnu,mips64el-linux-gnu,powerpc-linux-gnu,powerpc64-linux-gnu,powerpc64le-linux-gnu,s390x-linux-gnu,sh-linux-gnu,sh64-linux-gnu,sparc-linux-gnu,sparc64-linux-gnu,x86_64-linux-gnu,x86_64-linux-gnux32,x86_64-pep

_binutils(){
    local binutils

    binutils=$(find $MY_BIN -maxdepth 1 -type d  | s 'binutils-.*')

    if [[ "$#" == 1 ]];then
        (
        COMMAND=$1
        shift
        $binutils/binutils/$COMMAND
        )
    else
        (
        COMMAND=$1
        shift
        $binutils/binutils/$COMMAND "$@"
        )
    fi
}

_completion_register_write _binutils addr2line
_completion_register_write _binutils ar
_completion_register_write _binutils cxxfilt
_completion_register_write _binutils elfedit
_completion_register_write _binutils embedspu
_completion_register_write _binutils libtool
_completion_register_write _binutils nm-new
_completion_register_write _binutils objcopy
_completion_register_write _binutils objdump
_completion_register_write _binutils readelf
_completion_register_write _binutils size
_completion_register_write _binutils strings
_completion_register_write _binutils strip-new
_completion_register_write _binutils sysinfo

_completion_setup _binutils
