#!/usr/bin/python

import sys

current_word = None
word_count = 0
for line in sys.stdin:
    key, count = line.split("\t",1)
    count = int(count)
    if key != current_word:
        if current_word:
            print "%s\t%d"%(current_word, word_count)
        current_word = key
    word_count += count
if current_word:
    print "%s\t%d"%(current_word, word_count)
