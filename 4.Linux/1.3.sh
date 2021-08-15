#!/bin/bash
echo "Enter str"
read -t 5 -r str <&1
if [ -z "$str" ]
then
  echo "Error 5 seconds passed"
else
  echo "str = $str"
fi  
