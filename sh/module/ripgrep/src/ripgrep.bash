#! /usr/bin/env bash

export PATH="$(_autodetect_bin 'ripgrep-.*-apple-darwin'):$PATH"
_completion_setup rg

_completion_register_write rg -a
_completion_register_write rg --text

_completion_register_write rg -c
_completion_register_write rg --count

_completion_register_write rg --color

_completion_register_write rg -e
_completion_register_write rg --regexp

_completion_register_write rg -F
_completion_register_write rg --fixed-strings

_completion_register_write rg -g
_completion_register_write rg --glob

_completion_register_write rg -h
_completion_register_write rg --help

_completion_register_write rg -i
_completion_register_write rg --ignore-case

_completion_register_write rg -n
_completion_register_write rg --line-number

_completion_register_write rg -N
_completion_register_write rg --no-line-number

_completion_register_write rg -q
_completion_register_write rg --quiet

_completion_register_write rg -t
_completion_register_write rg --type

_completion_register_write rg -T
_completion_register_write rg --type-not

_completion_register_write rg -u
_completion_register_write rg --unrestricted

_completion_register_write rg -v
_completion_register_write rg --invert-match

_completion_register_write rg -w
_completion_register_write rg --word-regexp

_completion_register_write rg -A
_completion_register_write rg --after-context

_completion_register_write rg -B
_completion_register_write rg --before-context

_completion_register_write rg -C
_completion_register_write rg --context

_completion_register_write rg --column

_completion_register_write rg --context-separator

_completion_register_write rg --debug

_completion_register_write rg --files

_completion_register_write rg -l
_completion_register_write rg --files-with-matches

_completion_register_write rg -H
_completion_register_write rg --with-filename

_completion_register_write rg --no-filename

_completion_register_write rg --heading

_completion_register_write rg --no-heading

_completion_register_write rg --hidden

_completion_register_write rg --ignore-file

_completion_register_write rg -L
_completion_register_write rg --follow

_completion_register_write rg -m
_completion_register_write rg --max-count

_completion_register_write rg --maxdepth

_completion_register_write rg --mmap

_completion_register_write rg --no-messages

_completion_register_write rg --no-mmap

_completion_register_write rg --no-ignore

_completion_register_write rg --no-ignore-parent

_completion_register_write rg --no-ignore-vcs

_completion_register_write rg --null

_completion_register_write rg -p
_completion_register_write rg --pretty

_completion_register_write rg -r
_completion_register_write rg --replace

_completion_register_write rg -s
_completion_register_write rg --case-sensitive

_completion_register_write rg -S
_completion_register_write rg --smart-case

_completion_register_write rg -j
_completion_register_write rg --threads

_completion_register_write rg --version

_completion_register_write rg --vimgrep

_completion_register_write rg --type-list

_completion_register_write rg --type-add

_completion_register_write rg --type-clear
