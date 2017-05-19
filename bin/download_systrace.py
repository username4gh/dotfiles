#! /usr/bin/env python
# coding=UTF-8

import os
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
                    self._file_size(output)
                else:
                    break
                self._file_size(output)
        except Exception as exception:
            print exception

        finally:
            if output is not None:
                output.close()
        return 0


class Version:
    def __init__(self):
        self.major = 0
        self.mid = 0
        self.minor = 0

    # noinspection PyRedeclaration
    def __init__(self, major, mid, minor):
        self.major = major
        self.mid = mid
        self.minor = minor

    def __str__(self):
        return str(self.major) + '.' + str(self.mid) + '.' + str(self.minor)


base_url = 'https://dl.google.com/android/repository/'


def _url(version):
    url = base_url + 'platform-tools_r' + str(version) + '-darwin.zip'
    return url


def main(argv=sys.argv):
    downloader = Downloader()
    for x in range(1, 5):
        version = Version(24, 0, x)
        downloader.download(_url(version))


sys.exit(main())
