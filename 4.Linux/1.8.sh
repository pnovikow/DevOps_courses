#!/bin/bash

for ((i=1;i<701;i++))
 do
   num=$((RANDOM%6+1))
 case $num in
'1')
let "ones++";;
"2")
let "twos++";;
'3')
let "threes++";;
'4')
let "fours++";;
'5')
let "fives++";;
'6')
let "sixes++";;
 esac
done
echo "единиц	 =	$ones"
echo "двоек	 =	$twos"
echo "троек	 =	$threes"
echo "четверок	 =	$fours"
echo "пятерок	 =	$fives"
echo "шестерок	 =	$sixes"
