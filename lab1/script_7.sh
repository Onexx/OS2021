#!/bin/bash
REGEX="[a-zA-Z0-9_\-\.]+@[a-zA-Z0-9_\-]+.[a-z]+"
grep -I -h -r -o -E "$REGEX" /etc | sort | uniq | awk '{printf("%s, ", $0)}' > emails.lst
