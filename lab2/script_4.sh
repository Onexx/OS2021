#!/bin/bash

> tmp
for i in $(ps -A -o pid --no-header)
do
	fstat=/proc/$i/status
	if [[ -f $fstat ]]
	then
		ppid=$(grep PPid $fstat | awk '{ print $2 }')
		ser=$(grep "sum_exec_runtime" "/proc/$i/sched" | awk '{ print $3 }')
		ns=$(grep "nr_switches" "/proc/$i/sched" | awk '{ print $3 }')
		art=$(echo $ser  $ns | awk '{ print $1/$2 }')
		echo "ProcessID= $i : Parent_ProcessID= $ppid : Average_Running_Time= $art" >> tmp
	fi
done
cat tmp | sort -nk5 > ans_4.lst
rm tmp
