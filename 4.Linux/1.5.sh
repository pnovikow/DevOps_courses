#!/bin/bash
until [ -z "$1" ]
do 
 echo -n "$1 "
 shift
done
echo
