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

export elements=$(cat<<EOF
<a id='playGroup' display='none' onclick='Play()'>
      <circle id='play' cx='450' cy='50' r='15' fill='green'/>
      <polygon points='446,44 457,50 46,56' fill='lime' stroke='lime' stroke-width='2' stroke-linejoin='round'/>
</a>

<a id='pauseGroup' display='inline' onclick='Pause()'>
      <circle id='pause' cx='450' cy='50' r='15' fill='red'/>
      <line x1='447' y1='45' x2='447' y2='55' stroke='pink' stroke-width='4' stroke-linecap='round'/>
      <line x1='454' y1='45' x2='454' y2='55' stroke='pink' stroke-width='4' stroke-linecap='round'/>
</a>

EOF

		  
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
    gsed -r "s/(\<!--Animation.*--\>)/\1 #$(echo "$script"|tr "\n" "#")/g;s/#/\n/g" | \
    gsed -r "s/\<\/svg\>/#$(echo "$elements"|tr "\n" "#") \1/g;s/#/\n/g"
