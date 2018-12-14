#! /usr/bin/env bash

# ./configure --enable-targets=aarch64-linux-gnu,aarch64_be-linux-gnu,alpha-linux-gnu,hppa-linux-gnu,arm-linux-gnueabi,i686-linux-gnu,m32r-linux-gnu,m68k-linux-gnu,m68k-rtems,mips-linux-gnu,mipsel-linux-gnu,mips64-linux-gnu,mips64el-linux-gnu,powerpc-linux-gnu,powerpc64-linux-gnu,powerpc64le-linux-gnu,s390x-linux-gnu,sh-linux-gnu,sh64-linux-gnu,sparc-linux-gnu,sparc64-linux-gnu,x86_64-linux-gnu,x86_64-linux-gnux32,x86_64-pep

_binutils(){
    local binutils

    binutils=$(find $MY_BIN -maxdepth 1 -type d  | pythongrep 'binutils-.*')

    (
    COMMAND=$1
    shift
    $binutils/binutils/$COMMAND "$@"
    )
}

_annotation_completion_write _binutils addr2line
_annotation_completion_write _binutils ar
_annotation_completion_write _binutils cxxfilt
_annotation_completion_write _binutils elfedit
_annotation_completion_write _binutils embedspu
_annotation_completion_write _binutils libtool
_annotation_completion_write _binutils nm-new
_annotation_completion_write _binutils objcopy
_annotation_completion_write _binutils objdump
_annotation_completion_write _binutils readelf
_annotation_completion_write _binutils size
_annotation_completion_write _binutils strings
_annotation_completion_write _binutils strip-new
_annotation_completion_write _binutils sysinfo

_completion_setup _binutils
