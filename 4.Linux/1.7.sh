#!/bin/bash
read -r a
b=0.0006214
echo "$a*$b" | bc -l
