#!/bin/bash
ans=""
max=0
for i in $(ps -A -o pid --no-headers)
do
	file=/proc/$i/status
	if [[ -f $file ]]
	then
		cur=$(grep VmSize $file | awk '{ print $2 }')
		if [[ $cur -gt $max ]]
		then
			max=$cur
			ans=$i
		fi
	fi
done
echo $ans $max
