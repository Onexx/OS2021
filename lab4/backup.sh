#!/bin/bash
user_dir="/home/user"
report="$user_dir/backup-report"
date=$(date +%F)
last_backup_date=$(ls "$user_dir" | grep "^Backup-" | sort -n | tail -1 | cut -d "-" -f 2,3,4)
if [[ -z $last_backup_date ||
$(($(date -d $date +%s) - $(date -d $last_backup_date +%s))) -gt $((7*60*60*24)) ]];
then
	echo "Creating new backup"
	backup_dir="Backup-"$date
	mkdir $user_dir/$backup_dir
	cp -r $user_dir/source/* $user_dir/$backup_dir
	{
	  echo "$date: Backup created at folder $backup_dir"
	  ls -R $user_dir/source
	  printf "\n\n"
	  } >> $report
	echo "Completed"
else
	new_files=""
	renamed_files=""
	backup_dir="Backup-"$last_backup_date
	echo "Updating backup"
	echo "$date: Backup updated at $backup_dir" >> $user_dir/backup-report

	files_in_source=$(ls $user_dir/source)
	for cur_file in $files_in_source
	do
		src="$user_dir/source/$cur_file"
		dest="$user_dir/$backup_dir/$cur_file"
		if [[ -f $dest ]]
		then
			src_size=$(ls -l $src | awk '{print$5}')
			dest_size=$(ls -l $dest | awk '{print$5}')
			if [[ $src_size -ne $dest_size ]]
			then
				mv $dest $dest.$date
				cp $src $user_dir/$backup_dir
				renamed_files+="$cur_file -> $cur_file.$date\n"
			fi
		else
			cp $src $user_dir/$backup_dir
			new_files+="$cur_file\n"
		fi
	done
	echo -e "New files:\n$new_files\nUpdated files:\n$renamed_files\n\n" >> $report
	echo "Completed"
fi
