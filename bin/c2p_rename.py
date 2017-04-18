#! /usr/bin/env python
# coding=UTF-8

# https://geekwardnote.wordpress.com/2013/02/08/how-to-rename-chinese-file-to-pinyin/

# Rename filename from Chinese characters to capitalized pinyin using the
# mapping file and taking out the tone numbers

import os
import re

# File uni2pinyin is a mapping from hex to Pinyin with a tone number
mapping_file = os.path.join(os.getenv('MY_BUNDLED_BIN'), 'uni2pinyin')
f = open(mapping_file)
wf = f.read() # read the whole mapping file

myulist = os.listdir(u'.') # read all file names in unicode mode
for x in myulist: # each file name
    filenamePY = ''
    for y in x: # each character
        if 0x4e00 <= ord(y) <= 0x9fff: # Chinese Character Unicode range
            hexCH = (hex(ord(y))[2:]).upper() # strip leading '0x' and change
                                              # to uppercase
            p = re.compile(hexCH+'\t([a-z]+)[\d]*') # define the match pattern
            mp = p.search(wf)
            filenamePY+= mp.group(1).title() # get the pinyin without the tone
                                            # number and capitalize it
        else:
            filenamePY+=y
    filename = filenamePY.lower()

    # skip the directory
    if os.path.isfile(x):
        print(x + ' -> ' + filename)
        os.rename(x, filename)
