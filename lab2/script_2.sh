#!/bin/bash
ps -A -o pid,cmd | grep /sbin/ | awk '{ print $1 }' > ans_2.lst
