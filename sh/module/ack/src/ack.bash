#! /usr/bin/env bash

if [[ "$(_check_file "$MY_BIN/ack")" == 0 ]];then
    curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 "$MY_BIN/ack"
fi

_completion_setup ack

_completion_register_write ack -i
_completion_register_write ack --ignore-case

_completion_register_write ack --nosmart-case
_completion_register_write ack --smart-case

_completion_register_write ack -v
_completion_register_write ack --invert-match

_completion_register_write ack -w
_completion_register_write ack --word-regexp

_completion_register_write ack -Q
_completion_register_write ack --literal

_completion_register_write ack --lines=

_completion_register_write ack -l
_completion_register_write ack --files-with-matches

_completion_register_write ack -L
_completion_register_write ack --files-without-matches

_completion_register_write ack --output=

_completion_register_write ack -o

_completion_register_write ack --passthru

_completion_register_write ack --match

_completion_register_write ack -m
_completion_register_write ack --max-count=

_completion_register_write ack -1

_completion_register_write ack -H
_completion_register_write ack --with-filename

_completion_register_write ack -h
_completion_register_write ack --no-filename

_completion_register_write ack -c
_completion_register_write ack --count

_completion_register_write ack --nocolumn
_completion_register_write ack --column

_completion_register_write ack -A
_completion_register_write ack --after-context=

_completion_register_write ack -B
_completion_register_write ack --before-context=

_completion_register_write ack -C
_completion_register_write ack --context[=NUM]

_completion_register_write ack --print0

_completion_register_write ack -s

_completion_register_write ack --pager=

_completion_register_write ack --nopager

_completion_register_write ack --noheading
_completion_register_write ack --heading

_completion_register_write ack --nobreak
_completion_register_write ack --break

_completion_register_write ack --group
_completion_register_write ack --nogroup

_completion_register_write ack --nocolor
_completion_register_write ack --color

_completion_register_write ack --nocolour
_completion_register_write ack --colour

_completion_register_write ack --color-filename=COLOR
_completion_register_write ack --color-match=COLOR
_completion_register_write ack --color-lineno=COLOR

_completion_register_write ack --flush

_completion_register_write ack -f

_completion_register_write ack -g

_completion_register_write ack --sort-files

_completion_register_write ack --show-types

_completion_register_write ack --files-from=FILE

_completion_register_write ack -x

_completion_register_write ack --noignore-dir=
_completion_register_write ack --ignore-dir=

_completion_register_write ack --noignore-directory=
_completion_register_write ack --ignore-directory=

_completion_register_write ack --ignore-file=

_completion_register_write ack -r
_completion_register_write ack -R
_completion_register_write ack --recurse

_completion_register_write ack -n
_completion_register_write ack --no-recurse

_completion_register_write ack --nofollow
_completion_register_write ack --follow

_completion_register_write ack -k
_completion_register_write ack --known-types

_completion_register_write ack --type=X
_completion_register_write ack --type=noX

_completion_register_write ack --type-set
_completion_register_write ack --type-add
_completion_register_write ack --type-del

_completion_register_write ack --noenv
_completion_register_write ack --env

_completion_register_write ack --ackrc=

_completion_register_write ack --ignore-ack-defaults

_completion_register_write ack --create-ackrc

_completion_register_write ack --help

_completion_register_write ack --help-types

_completion_register_write ack --dump

_completion_register_write ack --nofilter
_completion_register_write ack --filter

_completion_register_write ack --man

_completion_register_write ack --version

_completion_register_write ack --thpppt

_completion_register_write ack --bar

_completion_register_write ack --cathy
