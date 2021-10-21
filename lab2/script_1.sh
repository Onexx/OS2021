#!/bin/bash
ps -e -o user | grep -c root > ans_1.lst
ps -A -o pid,cmd,user | grep root | awk '{ print($1, ":", $2) }' >> ans_1.lst
