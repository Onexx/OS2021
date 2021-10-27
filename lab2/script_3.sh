#!/bin/bash
ps --pid $$ --ppid $$ -N -o pid,stime,comm --sort=stime --no-headers | tail -1 | awk '{ print $1 }'
