#! /usr/bin/env python
# coding=UTF-8

import os
import sys

BASH_HISTORY = os.path.join(os.environ.get('HOME'), '.bash_history')

BASH_HISTORY_ARCHIVE = os.path.join(os.environ.get('HOME'), '.bash_history.archive')

TMP = dict()

def _is_legit_command(line):
    if ('#' not in line) and ('[' not in line):
        return True
    else:
        return False

def _handling_history_file(history_file):
    history_lines = history_file.readlines()

    for line in history_lines:
        if _is_legit_command(line):
            key = str(str(line).split(' ')[0]).strip('\n')
            if key not in TMP:
                TMP[key] = 1
            else:
                TMP[key] = TMP[key] + 1



def main(argv=sys.argv):
    history_file = open(BASH_HISTORY, 'r')
    history_archive_file = open(BASH_HISTORY_ARCHIVE, 'r')

    _handling_history_file(history_file)
    _handling_history_file(history_archive_file)
        
    iterator = TMP.iteritems()

    item = iterator.next()
    try:
        while item is not None:
            print item
            item = iterator.next()
    except StopIteration as ex:
        print ex.message

sys.exit(main())
