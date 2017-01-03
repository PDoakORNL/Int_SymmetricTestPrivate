#!/bin/bash
cd /data/monitor_cades
dir=`date +'%b%d_%Y'`
mkdir $dir
cd $dir
rsync -av or-condo-login:~/monitor/${dir}/\* ./
find ./ -name 'CADES_JOBS*' | xargs python ../nodeMassageMany.py
../animate/makeAnim.sh
cp prunj.svg /data/monitor/prunj${dir}.svg
