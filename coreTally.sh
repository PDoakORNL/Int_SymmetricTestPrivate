#!/bin/bash
for i in $(seq 1 480)
do
   cores=`~/allCNMS.sh | tail -1 `
   date=$(date -R)
   echo "${date} ${cores}" >>CNMS_core_tally
   sleep 30
done
