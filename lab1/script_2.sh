#!/bin/bash
A=""
read S
while [[ $S != "q" ]]
do
	A=$A$S
	read S
done
echo $A
