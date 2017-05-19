#! /usr/bin/env python
# coding=UTF-8

import re
import sys
import urllib2

class Downloader:
    def __init__(self):
        """ do nothing
        """

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
            print 'trying to download ' + url

        output = None
        try:
            result = urllib2.urlopen(url)
            filename = self._name_from_url(url)
            output = open("./" + filename, "wb")

            while True:
                data = result.read(1024 * 1024)
                if len(data) != 0:
                    output.write(data)
                    print self._file_size(filename)
                else:
                    break
                print self._file_size(filename)
        except Exception as exception:
            print exception

        finally:
            if output is not None:
                output.close()
        return 0

def main(argv=sys.argv):
    print argv
    if len(argv) == 1:
        print 'Usage: dl.py <url>'

    dl = Downloader()
    dl.download(argv[1])

sys.exit(main())
