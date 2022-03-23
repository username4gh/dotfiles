#! /usr/bin/env python
# coding=utf-8

import argparse
import sys


def build_option_parser():
    parser = argparse.ArgumentParser(argparse.SUPPRESS, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-<x>', '--<x>', dest='<x>', action='store_true', help='<help text>')
    return parser


def main(argv):
    parser = build_option_parser()

    if len(sys.argv) == 1:
        parser.print_help()
        sys.exit(0)

    options, args = parser.parse_known_args(argv[1:])


if __name__ == '__main__':
    main(sys.argv)
