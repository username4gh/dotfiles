#! /usr/bin/env bash

export PATH_TO_LLVM_ROOT="$(_autodetect_bin 'clang\+llvm-.*-apple-darwin')"
export PATH="$PATH_TO_LLVM_ROOT/bin:$PATH"
