#!/bin/perl

my $script = << 'END_SCRIPT';
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

END_SCRIPT

$elements = <<'END_BUTTON';
<a id='playGroup' display='none' onclick='Play()'>
      <circle id='play' cx='450' cy='50' r='15' fill='green'/>
      <polygon points='446,44 457,50 446,56' fill='lime' stroke='lime' stroke-width='2' stroke-linejoin='round'/>
</a>

<a id='pauseGroup' display='inline' onclick='Pause()'>
      <circle id='pause' cx='450' cy='50' r='15' fill='red'/>
      <line x1='447' y1='45' x2='447' y2='55' stroke='pink' stroke-width='4' stroke-linecap='round'/>
      <line x1='454' y1='45' x2='454' y2='55' stroke='pink' stroke-width='4' stroke-linecap='round'/>
</a>

END_BUTTON

while(<>) {
  $_=~s/(\<svg.*width=\"[0-9]+\")\>/ $1 onload=\"Init(evt)\" >/;
  $_=~s/(\<!--Animation.*?--\>)/$1 $script/; 
  $_=~s/\<\/svg\>/ $elements <\/svg>/;
  print "$_";
}
