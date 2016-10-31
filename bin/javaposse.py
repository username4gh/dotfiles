#! /usr/bin/env python
# coding=UTF-8

import os
import re
import sys
import urllib2

def _file_size(filename):
    filesize = os.path.getsize(filename)
    if filesize < 1024:
        print str(filesize) + 'bytes'
        return
    if filesize < 1024 * 1024:
        print str(filesize/1024) + "KB"
        return
    if filesize < 1024 * 1024 * 1024:
        print str(filesize/1024/1024) + "MB"
        return
    if filesize < 1024 * 1024 * 1024 * 1024:
        print str(filesize/1024/1024/1024) + "GB"
        return
    

def _name_from_url(url):
    index = url.rfind('/')
    name = url[index + 1:]
    return name

def _download(url):
    result = urllib2.urlopen(url)
    filename = _name_from_url(url)
    output = open("./"+ filename, "wb")

    while True:
        data = result.read(1024 * 1024)
        if len(data) != 0 :
            output.write(data)
            print os.path.getsize(filename)
        else:
            break
    output.close()
    return 0

base_url = 'http://traffic.libsyn.com/dickwall/JavaPosse'

def main(argv=sys.argv):
    for i in xrange(1, 462):
        if len(str(i)) == 1:
            url = base_url +  '00' + str(i) + '.mp3'
        if len(str(i)) == 2:
            url = base_url + '0' + str(i) + '.mp3'
        if len(str(i)) == 3:
            url = base_url + str(i) + '.mp3'

        print url
        _download(url)
    

sys.exit(main())
