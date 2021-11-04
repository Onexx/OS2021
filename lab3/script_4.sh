#!/bin/bash

> pids
./process.sh &
pid1=$!
./process.sh &
./process.sh &
pid3=$!
echo "pid1 = $pid1"
echo "pid2 = $pid3"
cpulimit -l 10 -p $pid1 &
kill $pid3


