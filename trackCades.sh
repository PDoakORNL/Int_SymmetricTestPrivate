#!/bin/bash

running=$(qstat | awk '(/.*or-condo/) && ($5 == "R") {print $1}' | xargs -n1 echo)

jobNum=0
echo `date -R`

for job in ${running[@]}
do
    nodes=$(checkjob $job | awk 'BEGIN {FS=":[0-9][0-9]*\\]\\[||:|\\[|:[0-9][0-9]*\\]"}; /or\-/ {for (i=1; i<=NF; i++) { if (length($i)>0) print $i}}')
    #/or-/ {FS=":"; for (i=1; i <= NF; i++) { print $i}}')
    rlength=$(checkjob $job| awk '/Reservation/ {print $0}' | sed -r 's/.*->\s+([-0-9|\:]+).*/\1/')
    acct=$(checkjob $job| awk '/Creds:/ {print $4}' | sed -r 's/.*:(.*)/\1/')
    #echo $job
    #echo $nodes
    jobn=`expr $job : '\([0-9]*\)'`
    for node in ${nodes[@]}
    do
#	echo "node $node"
	if [[ $rlength =~ ([0-9]*):([0-9]*)(:[0-9]*:[0-9]*) ]]
	then
	    hours=$(expr $(expr ${BASH_REMATCH[1]} \* 24) + ${BASH_REMATCH[2]})
	    rlength="${hours}${BASH_REMATCH[3]}"
	fi
	
	nnum=(`expr $node : '.*-c\([0-9][0-9]*\)'`)
	
	echo "$nnum $rlength $jobn $acct"
    done
done
