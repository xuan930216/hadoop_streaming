#!/usr/bin/python

import sys
import re

for line in sys.stdin:
    line = line.strip()
    words = re.split("\W*\s\W*", line)
    for word in words:
        print(word, 1, sep="\t")