#!/bin/bash

if [[ $# -ne 1 ]]
then
	echo "Error: Only one argument required"
	exit
fi

if [[ ! -f "$1" ]]
then
	echo "Error: File doesn't exist"
	exit
fi

trash_folder=".trash"
trash_log=".trash.log"

if [[ ! -d $trash_folder ]]
then
	mkdir $trash_folder
fi

if [[ ! -f $trash_log ]]
then
	touch $trash_log
fi

n=$(ls $trash_folder | wc -l)
(( n++ ))

ln "$1" $trash_folder/$n
rm "$1"
echo $(realpath "$1") $n >> $trash_log
echo "File $1 was removed successfully"
