#!/bin/bash

> tmp
for i in $(ps -A -o pid --no-header --sort=ppid)
do
	ppid=$( grep -s PPid "/proc/$i/status" | awk '{ print $2 }')
	ser=$(grep -s "sum_exec_runtime" "/proc/$i/sched" | awk '{ print $3 }')
	ns=$(grep -s "nr_switches" "/proc/$i/sched" | awk '{ print $3 }')
	( [ -z $ppid ] || [ -z $ser ] || [ -z $ns ] ) && continue
	art=$(echo $ser  $ns | awk '{ print $1/$2 }')
	echo "ProcessID= $i : Parent_ProcessID= $ppid : Average_Running_Time= $art" >> tmp
done
cat tmp > ans_4.lst
rm tmp
