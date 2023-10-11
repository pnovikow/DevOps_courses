#!/bin/bash
string=$USER
if [ "$string" == "root" ]; then
    echo "YEs.the script runs as user root"
else
    echo "No. the script runs as user $USER"
fi