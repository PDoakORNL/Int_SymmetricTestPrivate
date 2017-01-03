#!/bin/bash
export PATH=/opt/torque/bin/:$PATH
cd /home/epd/monitor
dir=`date +'%b%d_%Y'`
mkdir $dir
cd $dir
for i in $(seq 1 288)
do
    printf -v dr "%0.3d" $i
    echo $dr
    ../trackCades.sh >CADES_JOBS_$dr
    sleep 300
done
