#! /usr/bin/env python
# coding=UTF-8

import sys
import urllib2 as ul

def _name_from_url(url):
    index = url.rfind('/')
    name = url[index + 1:]
    return name

def _download(url):
    result = ul.urlopen(url)

    output = open("./"+ _name_from_url(url), "wb")

    while True:
        data = result.read(512)
        if len(data) != 0 :
            print len(data)
            output.write(data)
        else:
            break
    return 0

def main(argv=sys.argv):
    print _name_from_url('https://www2.eecs.berkeley.edu/Pubs/TechRpts/2006/EECS-2006-2.pdf')

sys.exit(main())
