#!/bin/bash
ps -e -o pid,start --no-headers | sort -rk2 | head -1 | awk '{ print $1 }'
