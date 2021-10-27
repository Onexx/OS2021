#!/bin/bash

ps -e -o pid,cmd | awk '$2 ~ "^/sbin/" { print $0 }' > ans_2.lst
