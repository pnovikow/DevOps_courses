#!/bin/bash

ones=0
twos=0
threes=0
fours=0
fives=0
sixes=0
zeros=0
for (( x=0; x<700; x++ ))
do
  case $(($RANDOM%6)) in
    0)
    let "ones++"
    ;;
    1)
    let "twos++"
    ;;
    2)
    let "threes++"
    ;;
    3)
    let "fours++"
    ;;
    4)
    let "fives++"
    ;;
    5)
    let "sixes++"
    ;;
esac
done
echo "едениц  =   $ones"
echo "двоек   =   $twos"
echo "троек   =   $threes"
echo "четвёрок  =   $fours"
echo "пятёрок   =   $fives"
echo "шестёрок  =   $sixes"
echo "всего бросков   =   $(($ones + $twos + $threes + $fours + $fives + $sixes))"
