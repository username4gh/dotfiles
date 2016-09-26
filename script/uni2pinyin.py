#! /usr/bin/env python
# coding=UTF-8

# https://geekwardnote.wordpress.com/2013/02/08/how-to-rename-chinese-file-to-pinyin/

# renameCH2Pinyin.py
# Rename filename from Chinese characters to capitalized pinyin using the
# mapping file and taking out the tone numbers
 
import os
import re
 
# File uni2pinyin is a mapping from hex to Pinyin with a tone number
f = open(os.path.join(os.getenv('HOME'), '.dotfiles/my-i3/script/uni2pinyin'))
wf = f.read() # read the whole mapping file
 
os.chdir('./images') # to rename all files in sub folder 'voc'
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
    print x
    filename = filenamePY
    print filename.lower()
    os.rename(x, filename.lower().replace('-', '_'))
os.chdir('..') # go back to the parent folder
