#! /usr/bin/env bash

echo "generating file list ..."
while IFS= read -r item;
do 
    readlink -m "$item"; 
done < <(find "$1" -name '*.aidl' -o -name '*.cc' -o -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.py' | s -i -v 'test') | sort | uniq > './cscope.files'


