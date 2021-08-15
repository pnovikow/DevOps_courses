#!/bin/bash
read -n1 -p "Enter 1 symbol: " -r symbol
case $symbol in

[a-z])
echo -n ":Lover"
;;

[A-Z])
echo -n ":Upper"
;;

[0-9])
echo -n ":Number"
;;

[","".""!""?"])
echo -n ":Mark"
;;

'')
echo -n ":Space"
;;

*)
echo -n ":Other"
;;
esac
echo
