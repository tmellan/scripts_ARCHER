#!/usr/bin/gnuplot

ef=system("head -6 DOSCAR | tail -1 | awk '{print $4}'")
name2=system("dir=`pwd` ; cd ../ && basename `pwd` && cd $dir ; basename `pwd`")
name3=system("echo ${PWD%}")
set xrange [-12:6]
set yrange [0:200]
set ylabel "DOS (states/64atoms)"
set xlabel "E-E_Fermi (eV)"
set title name3
plot "DOSCAR" u ($1-ef):2 every ::2500::5000 w l lw 2 title "Total DOS"
pause -1

