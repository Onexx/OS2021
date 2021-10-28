#!/bin/bash

date='date +"%d-%m-%Y_%T"'
report=~/report.txt
host="www.net_nikogo.ru"

rm -r ~/test

mkdir ~/test && {
	echo "catalog test was created successfully" > $report
	touch ~/test/$(date +"%F_%R")
}
ping -c1 $host || echo "ping failed" >> $report
