#!/bin/bash

for ((i=1;i<701;i++))
 do
   num=$((RANDOM%6+1))
 case $num in
'1')
let "ones+=1";;
"2")
let "twos+=1";;
'3')
let "threes+=1";;
'4')
let "fours+=1";;
'5')
let "fives+=1";;
'6')
let "sixes+=1";;
 esac
done
echo "единиц	 =	$ones"
echo "двоек	 =	$twos"
echo "троек	 =	$threes"
echo "четверок	 =	$fours"
echo "пятерок	 =	$fives"
echo "шестерок	 =	$sixes"
