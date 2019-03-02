#!/usr/bin/python

import sys
import re

for line in sys.stdin:
    line = line.strip()
    words = re.split("\W*\s\W*", line)
    for word in words:
        print "%s\t%d"%(word, 1)