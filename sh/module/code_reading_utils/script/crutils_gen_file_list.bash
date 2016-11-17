#! /usr/bin/env bash

echo "generating file list ..."
find "$1" -name '*.aidl' -o -name '*.cc' -o -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' | s -i -v 'test' | _readlink | sort | uniq > './cscope.files'


