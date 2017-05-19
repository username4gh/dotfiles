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
                    print 'output file size -- ' + self._file_size(filename)
                else:
                    break
                print 'output file size -- ' + self._file_size(filename)
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

    @staticmethod
    def generate():
        versions = []
        for major in range(22, 27):
            for mid in range(0, 4):
                for minor in range(0, 4):
                    versions.append(Version(major, mid, minor))
        return versions


    def __str__(self):
        return str(self.major) + '.' + str(self.mid) + '.' + str(self.minor)

class UrlGenerator:

    def __init__(self):
        self.__base_url = 'https://dl.google.com/android/repository/'

    def url(self, version):
        if version.major > 25:
            return self.__base_url + 'platform-tools_r' + str(version) + '-darwin.zip'
        elif version.major == 25:
            if version.minor > 3:
                return self.__base_url + 'platform-tools_r' + str(version) + '-darwin.zip'
        else:
            return self.__base_url + 'platform-tools_r' + str(version) + '-macosx.zip'


def main(argv=sys.argv):
    downloader = Downloader()
    urlGenerator = UrlGenerator()
    for version in Version.generate():
        downloader.download(urlGenerator.url(version))


sys.exit(main())
