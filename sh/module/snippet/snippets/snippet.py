#! /usr/bin/env python
# https://www.python.org/dev/peps/pep-0263/
# coding=UTF-8

import os
import re
import sys
import urllib2
from HTMLParser import HTMLParser


class Downloader:
    def __init__(self):
        pass

    @staticmethod
    def _file_size(file_name):
        file_size = os.path.getsize(file_name)
        if file_size < 1024:
            return str(file_size) + 'bytes'
        if file_size < 1024 * 1024:
            return str(file_size / 1024) + "KB"
        if file_size < 1024 * 1024 * 1024:
            return str(file_size / 1024 / 1024) + "MB"
        if file_size < 1024 * 1024 * 1024 * 1024:
            return str(file_size / 1024 / 1024 / 1024) + "GB"

    @staticmethod
    def _name_from_url(url):
        index = url.rfind('/')
        name = url[index + 1:]
        return name

    def download(self, url):
        if url is not None:
            print '[downloading] ' + url

        output = None
        try:
            result = urllib2.urlopen(url)
            filename = self._name_from_url(url)
            output = open("./" + filename, "wb")

            while True:
                data = result.read(1024)
                if len(data) != 0:
                    output.write(data)
                    print '[' + filename + ']' + self._file_size(filename)
                else:
                    print '[' + filename + ']' + self._file_size(filename)
                    break
        except Exception as exception:
            print exception

        finally:
            if output is not None:
                output.close()
        return 0


class MyHTMLParser(HTMLParser):

    def __init__(self):
        HTMLParser.__init__(self)

    def handle_starttag(self, tag, attrs):
        pass

    def handle_endtag(self, tag):
        pass

    def handle_charref(self, name):
        pass

    def handle_entityref(self, name):
        pass

    def handle_data(self, data):
        pass

    def handle_comment(self, data):
        pass

    def handle_decl(self, decl):
        pass

    def handle_pi(self, data):
        pass

    def unknown_decl(self, data):
        pass


def main(argv=sys.argv):
    pass



if __name__ == "__main__":
    sys.exit(main())    
