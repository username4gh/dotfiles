#! /usr/bin/env bash

RIPGREP_PATH="$(_autodetect_bin 'ripgrep')"
if [[ "${#RIPGREP_PATH}" -eq 0 ]];then
    _sh_log "${BASH_SOURCE[0]}" "ripgrep has not been installed yet"
else
    export PATH="$RIPGREP_PATH:$PATH"
fi
unset RIPGREP_PATH

_completion_setup rg

_annotation_completion_write rg -a
_annotation_completion_write rg --text

_annotation_completion_write rg -c
_annotation_completion_write rg --count

_annotation_completion_write rg --color

_annotation_completion_write rg -e
_annotation_completion_write rg --regexp

_annotation_completion_write rg -F
_annotation_completion_write rg --fixed-strings

_annotation_completion_write rg -g
_annotation_completion_write rg --glob

_annotation_completion_write rg -h
_annotation_completion_write rg --help

_annotation_completion_write rg -i
_annotation_completion_write rg --ignore-case

_annotation_completion_write rg -n
_annotation_completion_write rg --line-number

_annotation_completion_write rg -N
_annotation_completion_write rg --no-line-number

_annotation_completion_write rg -q
_annotation_completion_write rg --quiet

_annotation_completion_write rg -t
_annotation_completion_write rg --type

_annotation_completion_write rg -T
_annotation_completion_write rg --type-not

_annotation_completion_write rg -u
_annotation_completion_write rg --unrestricted

_annotation_completion_write rg -v
_annotation_completion_write rg --invert-match

_annotation_completion_write rg -w
_annotation_completion_write rg --word-regexp

_annotation_completion_write rg -A
_annotation_completion_write rg --after-context

_annotation_completion_write rg -B
_annotation_completion_write rg --before-context

_annotation_completion_write rg -C
_annotation_completion_write rg --context

_annotation_completion_write rg --column

_annotation_completion_write rg --context-separator

_annotation_completion_write rg --debug

_annotation_completion_write rg --files

_annotation_completion_write rg -l
_annotation_completion_write rg --files-with-matches

_annotation_completion_write rg -H
_annotation_completion_write rg --with-filename

_annotation_completion_write rg --no-filename

_annotation_completion_write rg --heading

_annotation_completion_write rg --no-heading

_annotation_completion_write rg --hidden

_annotation_completion_write rg --ignore-file

_annotation_completion_write rg -L
_annotation_completion_write rg --follow

_annotation_completion_write rg -m
_annotation_completion_write rg --max-count

_annotation_completion_write rg --maxdepth

_annotation_completion_write rg --mmap

_annotation_completion_write rg --no-messages

_annotation_completion_write rg --no-mmap

_annotation_completion_write rg --no-ignore

_annotation_completion_write rg --no-ignore-parent

_annotation_completion_write rg --no-ignore-vcs

_annotation_completion_write rg --null

_annotation_completion_write rg -p
_annotation_completion_write rg --pretty

_annotation_completion_write rg -r
_annotation_completion_write rg --replace

_annotation_completion_write rg -s
_annotation_completion_write rg --case-sensitive

_annotation_completion_write rg -S
_annotation_completion_write rg --smart-case

_annotation_completion_write rg -j
_annotation_completion_write rg --threads

_annotation_completion_write rg --version

_annotation_completion_write rg --vimgrep

_annotation_completion_write rg --type-list

_annotation_completion_write rg --type-add

_annotation_completion_write rg --type-clear
