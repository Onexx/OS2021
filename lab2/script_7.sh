#!/bin/bash
for i in $(ps -e -o pid)
do
	if [[ -f "/proc/$i/io" ]]
	then
		rb=$(grep read_bytes "/proc/$i/io" | awk '{ print $2 }')
		echo $i $rb >> tmp
	fi
done

#sleep 1m
sleep 5s

while read line
do
	pid=$(echo $line | awk '{ print $1 }')
	oldrb=$(echo $line | awk '{ print $2 }')
	if [[ -f "/proc/$pid/io" ]]
	then
		newrb=$(grep read_bytes "/proc/$pid/io" | awk '{ print $2 }')
		comm=$(tr -d '\0' </proc/$pid/cmdline)
		#echo $newrb $oldrb
		echo $pid $(echo $newrb $oldrb | awk '{ print $1-$2 }') ' : ' $comm  >> tmp2
	fi
done < tmp
sort -nk2 tmp2 | tail -n 3 > ans_7.lst
rm tmp
rm tmp2
