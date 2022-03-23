#! /usr/bin/env python3

import sys

input_str = sys.argv[1]

print(input_str.encode("ascii", 'backslashreplace'))
