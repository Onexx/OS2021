#!/bin/bash

ans=1
mode="+"

(tail -f pipe) |
while true; do
	read line
	case $line in
		QUIT)
			echo "exit"
			killall tail
			killall "gen_5.sh"
			exit
			;;
		\*) mode="*" ;;
		\+) mode="+" ;;
		*)
			if [[ ! "$line" =~ ^[0-9]+$ ]]; then
				echo "NAN: $line"
			else
				ans=$((ans $mode line))
			fi
			;;
	esac
	echo "Current result = $ans"
done
