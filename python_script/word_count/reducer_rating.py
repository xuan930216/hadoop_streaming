import sys

for line in sys.stdin:
    count, word = line.strip().split('\t', 1)
    count = int(count)
    print(word, count, sep="\t")