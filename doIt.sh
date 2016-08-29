#!/bin/bash

find ./ -name 'CADES_JOBS*' | xargs python ../nodeMassageMany.py
for fixedf in fixed_CADES_JOBS_*; do echo "$fixedf"; num=${fixedf/#*_/}; fixedfesc=${fixedf/\//\\/}; dt=$(head -1 $fixedf); sed -e "s/#fixedFile#/${fixedfesc}/" -e "s/#NUM#/${num}/" -e "s/#date#/${dt}/" < ../plotTrack.gp >tplotTrack.gp; gnuplot tplotTrack.gp; done
./svganimator/svganimator.py --basic -s 0.2 runjAug26.svg ./runningRes_*
