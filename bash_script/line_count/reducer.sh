#!/bin/bash
awk '{line_count += \$1} END { print line_count}'
