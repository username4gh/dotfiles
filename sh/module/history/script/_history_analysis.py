#! /usr/bin/env python
# coding=UTF-8

import os
import sys

BASH_HISTORY = os.path.join(os.environ.get('HOME'), '.bash_history')

BASH_HISTORY_ARCHIVE = os.path.join(os.environ.get('HOME'), '.bash_history.archive')

TMP = dict()

def _is_legit_command(line):
    if '#' in line:
        return False 

    if '[' in line:
        return False

    if ']' in line:
        return False

    if '(' in line:
        return False

    if ')' in line:
        return False

    return True

def _filte_out_command(line):
    return str(str(line).split(' ')[0]).strip('\n')

def _is_command_exist(cmd):
    command = 'command -v ' + cmd +' > /dev/null'
    try:
        if os.system(command) == 0:
            return True
        else:
            return False
    except Exception as err:
        print cmd
        return False

def _handling_history_file(history_file):
    history_lines = history_file.readlines()

    for line in history_lines:
        if _is_legit_command(line):
            key = _filte_out_command(line)
            if key not in TMP:
                if _is_command_exist(key):
                    TMP[key] = 1
            else:
                TMP[key] = TMP[key] + 1



def main(argv=sys.argv):
    history_file = open(BASH_HISTORY, 'r')
    history_archive_file = open(BASH_HISTORY_ARCHIVE, 'r')

    _handling_history_file(history_file)
    _handling_history_file(history_archive_file)

    iterator = TMP.iteritems()

    if iterator is not None:
        item = iterator.next()
        try:
            while item is not None:
                print item
                item = iterator.next()
        except StopIteration as ex:
            return 0
    # do nothing

sys.exit(main())
