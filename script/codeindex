#! /usr/bin/env bash

echo "cscope indexing ..."
find $PWD -name '*.aidl' -o -name '*.cc' -o -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.py' > './cscope.files'
cscope -bckq -i './cscope.files'

echo "ctags indexing ..."
ctags -R --links=no --tag-relative=yes --exclude=.svn --exclude=.git -f './tags'

echo "gnu global indexing ..."
gtags
