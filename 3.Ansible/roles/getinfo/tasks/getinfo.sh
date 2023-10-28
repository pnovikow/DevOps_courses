#!/bin/bash

arg_ip=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
arg_hostname=$(curl -s http://169.254.169.254/metadata/v1/hostname)
arg_avtor=$(curl -s http://169.254.169.254/metadata/v1/tags)
arg_id=$(curl -s http://169.254.169.254/metadata/v1/id)

rm host.ini
echo "[$arg_hostname]"
echo "uniqueID="$arg_id
echo "host_ip:"$arg_ip
echo "host_avtor:"$arg_avtor
