#! /usr/bin/env python
# coding=UTF-8

import optparse
import os
import sys

class OptionParser(optparse.OptionParser):
    """Option parser that separates using --version from using invalid options.

       By default optparse uses SystemExit with both. This parser uses custom
       VersionPrinted exception with --version.
    """

    def print_version(self, file=None):
        optparse.OptionParser.print_version(self, file)
        raise VersionPrinted()

class VersionPrinted(Exception):
    pass

def parse_cmdline(cmdline_args):
    """ Parse the list of command-line options and arguments and return a
        triple: options, args, parser -- the first two being the result of
        OptionParser.parse_args, and the third the parser object itself.`
    """
    optparser = OptionParser(
            usage='usage: %prog [options] <pattern>',
            description='',
            prog='switchEnv.py',
            add_help_option=False)

    optparser.add_option('--help',
            action='store_true', dest='help', default=False,
            help='Display this information')

    optparser.add_option('-p', '--path', action='store', dest='path', default=None, help='specific path to do search')

    options, args = optparser.parse_args(cmdline_args)

    return options, args, optparser


def main(argv=sys.argv):
    try:
        options, args, optparser = parse_cmdline(argv[0:])
    except VersionPrinted:
        return 0
    except SystemExit:
        return 2

    if (len(args) == 0) or options.help:
        optparser.print_help()
        return 0

    _deep_first_search(options.path)
    return 1

def _deep_first_search(path):
    absPath = os.path.abspath(path)
    dir_list = os.listdir(absPath)
    for directory in dir_list:
        subpath = os.path.join(absPath, directory)
        if os.path.isfile(subpath):
           print subpath
        if os.path.isdir(subpath):
            _deep_first_search(subpath)


sys.exit(main())
