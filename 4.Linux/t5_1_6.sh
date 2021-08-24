#!/bin/bash

echo "Input one symbol"
IFS=""
read symb
if [ ${#symb} == 1 ]; then
	echo "Input symbol is "
	case $symb in
	['a'-'z'])
		echo "Lowercase letter"
		;;
	['A'-'Z'])
		echo "Capital letter"
		;;
	[0-9])
		echo "Number"
		;;
	[' '])
		echo "Space"
		;;
	[,.?!])
		echo "Punctuation mark"
		;;
	*)
		echo "Another sign"
		;;
	esac
else
	echo "Wrong input length"
fi
