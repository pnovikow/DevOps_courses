#!/bin/bash

read -t 5 var1
if [ -z "$var1" ]; 
then
	echo "Input string is empty"
	exit
fi
echo "Your string: $var1"
