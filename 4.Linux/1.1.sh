#!/bin/bash
if [ "$(id -u)" != "0" ];
 then
   echo "This script not run as root"
	exit 1
 else
  echo "This script run as root"
fi
