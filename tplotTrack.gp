#!/usr/bin/gnuplot -persist
#
#    
#    	G N U P L O T
#    	Version 4.6 patchlevel 2    last modified 2013-03-14 
#    	Build System: Linux x86_64
#    
#    	Copyright (C) 1986-1993, 1998, 2004, 2007-2013
#    	Thomas Williams, Colin Kelley and many others
#    
#    	gnuplot home:     http://www.gnuplot.info
#    	faq, bugs, etc:   type "help FAQ"
#    	immediate help:   type "help"  (plot window: hit 'h')
# set terminal jpeg nocrop font "/usr/share/fonts/dejavu/DejaVuSans.ttf,12" fontscale 1.0 size 640,480 
# set output '/tmp/gnuplot32346Ctq'
unset clip points
set clip one
unset clip two
set bar 1.000000 front
set border 31 front linetype -1 linewidth 1.000
set zdata 
set ydata 
set xdata 
set y2data 
set x2data 
set boxwidth
set style fill   solid 1.00 border lt -1
set style rectangle back fc lt -3 fillstyle   solid 1.00 border lt -1
set style circle radius graph 0.02, first 0, 0 
set style ellipse size graph 0.05, 0.03, first 0 angle 0 units xy
set dummy x,y
set format x "% g"
set format y "% g"
set format x2 "% g"
set format y2 "% g"
set format z "% g"
set format cb "% g"
set format r "% g"
set angles radians
unset grid
set raxis
set key title ""
set key inside right top vertical Right noreverse enhanced autotitles nobox
set key noinvert samplen 4 spacing 1 width 0 height 0 
set key maxcolumns 0 maxrows 0
set key noopaque
unset label
unset arrow
set style increment default
unset style line
set style line 1  linetype 1 linecolor rgb "#1b9e77"  linewidth 1.000 pointtype 1 pointsize default pointinterval 0
set style line 2  linetype 1 linecolor rgb "#d95f02"  linewidth 1.000 pointtype 1 pointsize default pointinterval 0
set style line 3  linetype 1 linecolor rgb "#7570b3"  linewidth 1.000 pointtype 1 pointsize default pointinterval 0
set style line 4  linetype 1 linecolor rgb "#e7298a"  linewidth 1.000 pointtype 1 pointsize default pointinterval 0
set style line 5  linetype 1 linecolor rgb "#66a61e"  linewidth 1.000 pointtype 1 pointsize default pointinterval 0
set style line 6  linetype 1 linecolor rgb "#e6ab02"  linewidth 1.000 pointtype 1 pointsize default pointinterval 0
set style line 7  linetype 1 linecolor rgb "#a6761d"  linewidth 1.000 pointtype 1 pointsize default pointinterval 0
set style line 8  linetype 1 linecolor rgb "grey40"  linewidth 1.000 pointtype 1 pointsize default pointinterval 0
unset style arrow
set style histogram clustered gap 2 title  offset character 0, 0, 0
unset logscale
set offsets 0, 0, 0, 0
set pointsize 1
set pointintervalbox 1
set encoding default
unset polar
unset parametric
unset decimalsign
set view 60, 30, 1, 1
set samples 100, 100
set isosamples 10, 10
set surface
unset contour
set clabel '%8.3g'
set mapping cartesian
set datafile separator whitespace
unset hidden3d
set cntrparam order 4
set cntrparam linear
set cntrparam levels auto 5
set cntrparam points 5
set size ratio 0 1,1
set origin 0,0
set style data points
set style function lines
set xzeroaxis linetype -2 linewidth 1.000
set yzeroaxis linetype -2 linewidth 1.000
set zzeroaxis linetype -2 linewidth 1.000
set x2zeroaxis linetype -2 linewidth 1.000
set y2zeroaxis linetype -2 linewidth 1.000
set ticslevel 0.5
set mxtics default
set mytics default
set mztics default
set mx2tics default
set my2tics default
set mcbtics default
set xtics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0 autojustify
set xtics autofreq  norangelimit
set ytics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0 autojustify
set ytics autofreq  norangelimit
set ztics border in scale 1,0.5 nomirror norotate  offset character 0, 0, 0 autojustify
set ztics autofreq  norangelimit
set nox2tics
set noy2tics
set cbtics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0 autojustify
set cbtics  norangelimit
#set cbtics   ("edde" 0.00000, "sns" 1.00000, "bsd" 2.00000, "ccsi" 3.00000, "cnms" 4.00000)
set rtics axis in scale 1,0.5 nomirror norotate  offset character 0, 0, 0 autojustify
set rtics autofreq  norangelimit
set title "Cades Condo current running jobs" 
set title  offset character 0, 0, 0 font "" norotate
set timestamp bottom 
set timestamp "" 
set timestamp  offset character 0, 0, 0 font "" norotate
set rrange [ * : * ] noreverse nowriteback
set trange [ * : * ] noreverse nowriteback
set urange [ * : * ] noreverse nowriteback
set vrange [ * : * ] noreverse nowriteback
set xlabel "node count cumulative" 
set xlabel  offset character 0, 0, 0 font "" textcolor lt -1 norotate
set x2label "" 
set x2label  offset character 0, 0, 0 font "" textcolor lt -1 norotate
set xrange [ 0 : 155 ] noreverse nowriteback
set x2range [ * : * ] noreverse nowriteback
set ylabel "hours remaining" 
set ylabel  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set y2label "" 
set y2label  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set yrange [ 0.00000 : 300.00 ] noreverse nowriteback
set y2range [ * : * ] noreverse nowriteback
set zlabel "" 
set zlabel  offset character 0, 0, 0 font "" textcolor lt -1 norotate
set zrange [ * : * ] noreverse nowriteback
set cblabel "" 
set cblabel  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set cbrange [ 0 : 5 ] noreverse nowriteback
set zero 1e-08
set lmargin  -1
set bmargin  -1
set rmargin  -1
set tmargin  -1
set locale "en_US.UTF-8"
set pm3d explicit at s
set pm3d scansautomatic
set pm3d interpolate 1,1 flush begin noftriangles nohidden3d corners2color mean
set palette positive nops_allcF maxcolors 10 gamma 1.5 color model RGB 
set palette defined ( 0 0.1059 0.6196 0.4667, 0.1429 0.851 0.3725 0.007843, 0.2857 0.4588 0.4392 0.702,\
     0.4286 0.9059 0.1608 0.5412, 0.5714 0.4 0.651 0.1176, 0.7143 0.902 0.6706 0.007843, 0.8571 0.651 0.4627 0.1137,\
     1 0.4 0.4 0.4 )
set colorbox default
set colorbox vertical origin screen 0.9, 0.2, 0 size screen 0.05, 0.6, 0 front bdefault
set style boxplot candles range  1.50 outliers pt 7 separation 1 labels auto unsorted
set loadpath 
set fontpath 
set psdir
set fit noerrorvariables
set term svg
set output 'aug5_runningRes_048.svg'
plot 'runningJobs/fixed_AUG5_CADES_JOBS_048' using ($1+$5/2):3:5:($8+.25):cbtic(7) with boxes palette title ''

#    EOF
