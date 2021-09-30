#!/bin/bash
read A B C
echo "$A $B $C" | tr ' ' "\n" | sort -rn | head -n 1
