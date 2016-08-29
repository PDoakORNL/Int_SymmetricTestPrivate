#!/bin/bash

SED=sed


#=========== Actual Script

for fixedf in fixed_CADES_JOBS_*
do
    num=${fixedf/#*_/}
    fixedfesc=${fixedf//\//\\/}
    fixedfesc=${fixedfesc//\./\\\.}
    d=`head -1 $fixedf`
    sed -e "s/#fixedFile#/${fixedfesc}/" -e "s/#NUM#/${num}/" -e "s/#date#/${d}/" < ../plotTrack.gp > ./tplotTrack.gp
    gnuplot tplotTrack.gp
done

python ../svganimator/svganimator.py --basic -s 0.2 runj.svg ./runningRes_*
perl ../animate/addPause.pl < runj.svg > prunj.svg

