#!/bin/bash

user_dir="/home/user"
restore_dir=$user_dir/restore
if [[ ! -d $restore_dir ]]
then
	mkdir $restore_dir
fi
backup_dir=$(ls $user_dir | grep "^Backup-" | sort -n | tail -1 )
if [[ -z $backup_dir ]]
then
	echo "Error: No backups found"
	exit
fi
echo "Restoring from $backup_dir"
for file in $(ls $backup_dir)
do
	if [[ -z "$(echo $file | grep -E '.[0-9]{4}-[0-9]{2}-[0-9]{2}')" ]]
	then
		cp $backup_dir/$file $restore_dir
	fi
done
echo "Completed"
