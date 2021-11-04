#!/bin/bash
echo $$ > .pid

ans=1
mode="+"

usr1(){ mode="+"; }
usr2(){ mode="*"; }
term(){ mode="term"; }


trap 'usr1' USR1
trap 'usr2' USR2
trap 'term' SIGTERM

while true; do
	sleep 5
	case $mode in
		'*' | '+')
			ans=$(( ans $mode 2 ))
			echo "ans = $ans"
			;;
		term)
			echo "terminated"
			exit
			;;
	esac
done
