import sys

for line in sys.stdin:
    try:
        word, count = line.strip().split('\t',1)
        count = int(count)
    except ValueError as e:
        continue
    print(count, word, sep="\t")