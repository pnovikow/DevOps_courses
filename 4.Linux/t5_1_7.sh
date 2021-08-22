#!/bin/bash

re="^[+-]?[0-9]+([.][0-9]+)?$"
echo "Input distance in metres"
read symb
if  [[ $symb =~ $re ]] ; then
    expr $(bc<<<"scale=10;$symb/1609")
else
    echo "Input isn't a number"
fi
