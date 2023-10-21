#!/bin/bash

if (( EUID ))
then
	echo "Not root user"
else
	echo "Root user"
fi
exit 1
