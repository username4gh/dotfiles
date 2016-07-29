#! /usr/bin/env python
# coding=UTF-8

import re
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

def _match(result):
    pattern = '(?<=href=\").*?(?=\")'
    lines = result.readlines()
    for line in lines:
        match = re.search(pattern, line)
        if  match:
            print match.group()

base_url = 'https://www2.eecs.berkeley.edu/Pubs/TechRpts/'

def main(argv=sys.argv):
    #for year in xrange(1973, 2016):
    result = ul.urlopen(base_url + str(1973))
    _match(result)

sys.exit(main())
