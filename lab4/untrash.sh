#!/bin/bash

if [[ $# -ne 1 ]]
then
	echo "Error: Only one argument required"
	exit
fi

trash_log=".trash.log"
trash_folder=".trash"

IFS=$'\n'
for line in $(cat $trash_log)
do
	if [[ $line =~ $1 ]]
	then
		file=$(echo $line | cut -d " " -f 1)
		idx=$(echo $line | cut -d " " -f 2)
		echo "Restore $file? (y/n)"
		read resp
		if [[ "$resp" == "y" ]]
		then
			if [[ ! -d "$(dirname $file)" ]]
			then
				echo "Previous directory not found. Restoring to home"
				file="~/$(basename $file)"
				echo "$file"
			fi
			while [[ -f $file ]]
			do
				echo "File with this name already exists. Please enter new name:"
				read name
				file="$(dirname $file)/$name"
			done

			ln $trash_folder/$idx "$file"
			rm $trash_folder/$idx
			sed -i "\:$line:d" "$trash_log"
			echo "Restored $file"
			exit 0
		fi
	fi
done
