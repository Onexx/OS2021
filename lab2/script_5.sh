#!/bin/bash

> ans_5.lst

N=0
M=0
cnt=0
while read line
do
	curPPID=$(echo $line | grep -E -o 'Parent_ProcessID= [[:digit:]]+' | awk '{ print $2 }')
	if [[ $N -eq $curPPID ]]
	then
		((++cnt))
		curART=$(echo $line |
grep -E -o 'Average_Running_Time= [[:digit:]]+[.[:digit:]]*' | awk '{ print$2 }')
		M=$(echo $M $curART | awk '{ print $1+$2 }')
	else
		M=$(echo $M $cnt | awk '{ print $1/$2 }')
		#echo "N=$N M=$M cnt=$cnt"
		echo "Average_Runing_Children_of_ParentID= $N is $M" >> ans_5.lst
		N=$(echo $line | grep -E -o 'Parent_ProcessID= [[:digit:]]+' | awk '{ print $2 }')
		M=$(echo $line |
grep -E -o 'Average_Running_Time= [[:digit:]]+[.[:digit:]]*' | awk '{ print $2 }')
		cnt=1
	fi
	echo $line >> ans_5.lst
done < ans_4.lst
M=$(echo $M $cnt | awk '{ print $1/$2 }')
echo "Average_Running_Children_of_ParentID= $N is $M" >> ans_5.lst
