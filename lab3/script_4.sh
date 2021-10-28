#!/bin/bash

> pids
at now -f ./process.sh &
at now -f ./process.sh &
at now -f ./process.sh &

cpulimit -l 10 -p $(cat pids | head -n 1) &
kill $(cat pids | tail -n 1)

echo "$(cat pids | tail -n 1)"
