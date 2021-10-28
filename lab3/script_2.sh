#!/bin/bash

report=~/report.txt
at now +2 minute -f script_1.sh
tail -f $report &
