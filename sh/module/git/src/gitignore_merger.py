#! /usr/bin/env python
# coding=UTF-8

import optparse

def _lineIsValid(line):
    if '#' not in line:
        return True
    return False

def _lineDeduplication(inputfile, outputfile):
    lines = open(inputfile, 'r').readlines()
    lines_set = set(lines)
    lines_list = list(lines_set)
    lines_list.sort()
    out = open(outputfile, 'w')
    for line in lines_list:
        if _lineIsValid(line):
            out.write(line)

def main():
    parser = optparse.OptionParser('usage %prog ' +\
            '-i <inputfile> -o <outputfile>')
    parser.add_option('-i', dest='inputfile', type='string',
            help='specify your input file')
    parser.add_option('-o', dest='outputfile', type='string',
            help='specify your output file')
    (options, args) = parser.parse_args()
    inputfile = options.inputfile
    outputfile = options.outputfile
    if (inputfile == None) or (outputfile == None):
        print parser.usage
        exit(1)
    else:
        _lineDeduplication(inputfile, outputfile)

if __name__ == '__main__':
    main()
