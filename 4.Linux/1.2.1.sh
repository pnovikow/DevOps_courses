#!/bin/bash
echo "direct:"; read -r direct
echo "depth:"; read -r depth
echo "max size file:"; read -r max_size 
echo "max iterations:"; read -r max_iter
count_files=2; counter=1; 
mkdir "$direct"
cd "$direct" || exit

function generate_struct {

 while [[ $counter -le $count_files ]]
  do
  dd bs=$((RANDOM%$max_size+1)) count=$RANDOM skip=$RANDOM if="$PWD" of=random-file.$counter
  (( counter++ )) || true
 done
 
  if [ "$1" -le $(($depth)) ]
  then
    folders=$RANDOM
    let "folders%=max_iter"
    num=1
    
    while [ "$num" -le $(("$folders")) ]
    do
     direct="$2$num"
     mkdir "$direct"
     cd "$direct" || exit
     generate_struct $(( $1 + 1 )) "$next_folders"  
     num=$(($num+1))
    done
  fi
  cd ".."
}
generate_struct "$direct"
