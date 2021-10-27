#!/bin/bash
ps -U root -u root --no-headers -A -o pid,cmd > tmp
cat tmp | wc -l > ans_1.lst
cat tmp | awk '{ print $1 ":" $2 }' >> ans_1.lst
rm tmp
