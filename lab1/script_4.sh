#!/bin/bash
if [[ $HOME == $PWD ]]
then
	echo $HOME
	exit 0
else
	echo "Not in HOME directory"
	exit 1
fi
