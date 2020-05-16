#! /usr/bin/env python
# coding=UTF-8
# stolen from https://unix.stackexchange.com/questions/239898/listing-files-from-nested-zip-files-without-extracting

import zipfile
import io
import re
import sys

pattern = re.compile(".*\\.(jar|rar|zip)$")


def uz(f, parent=None):
    if parent is None:
        parent = []
    result = []
    try:
        zf = zipfile.ZipFile(f)
        for e in zf.namelist():
            path = parent + [e]
            if pattern.match(e.lower()):
                result += uz(io.BytesIO(zf.open(e).read()), path)
            else:
                result.append("/".join(path))
    except IOError:
        return result

    return result


def main(argv):
    path = argv[1]

    for line in uz(open(path, "rb")):
        print(line)


if __name__ == "__main__":
    sys.exit(main(sys.argv))
