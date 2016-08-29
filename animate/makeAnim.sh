#!/bin/bash

export script=$(cat<<EOF
    <script><![CDATA[
      var SVGDocument = null;
      var SVGRoot = null;
      var svgns = 'http://www.w3.org/2000/svg';
      var xlinkns = 'http://www.w3.org/1999/xlink';

      var pauseButton = null;
      var playButton = null;

      function Init(evt)
      {
         SVGDocument = evt.target.ownerDocument;
         SVGRoot = SVGDocument.documentElement;

         pauseButton = SVGDocument.getElementById('pauseGroup');
         playButton = SVGDocument.getElementById('playGroup');
      };

      function Pause()
      {
         SVGRoot.pauseAnimations();

         pauseButton.setAttributeNS(null, 'display', 'none');
         playButton.setAttributeNS(null, 'display', 'inline');
      };

      function Play()
      {
         SVGRoot.unpauseAnimations();
         playButton.setAttributeNS(null, 'display', 'none');
         pauseButton.setAttributeNS(null, 'display', 'inline');
      };

   ]]></script>

EOF
       )

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

cat runj.svg | gsed -r 's/(\<svg?.*width=\"[0-9]+\")\>/ \1 onload=\"Init\(evt\) \" \>/' | \
gsed -r "s/(\<!--Animation.*--\>)/\1 #$(echo "$script"|tr "\n" "#")/g;s/#/\n/g"
