#!/usr/bin/gnuplot

ef=system("head -6 DOSCAR | tail -1 | awk '{print $4}'")
name3=system("echo ${PWD%}")

set multiplot layout 2,2


set xrange [-12:6]
set yrange [0:0.5]
set ylabel "Projected DOS (states/atom)"
set xlabel "E-E_Fermi (eV)"
set title name3
set key right
p "<(sed -n '5010,9999p' DOSCAR)" u ($1-ef):2 smooth csplines w l lw 2 title "Zr s",\
  "<(sed -n '5010,9999p' DOSCAR)" u ($1-ef):3 smooth csplines w l lw 2 title "Zr p_x",\
  "<(sed -n '5010,9999p' DOSCAR)" u ($1-ef):4 smooth csplines w l lw 2 title "Zr p_y",\
  "<(sed -n '5010,9999p' DOSCAR)" u ($1-ef):5  smooth csplines w l lw 2 title "Zr p_z"
set key left
p "<(sed -n '5010,9999p' DOSCAR)" u ($1-ef):6  smooth csplines w l lw 2 title "Zr d_xy",\
  "<(sed -n '5010,9999p' DOSCAR)" u ($1-ef):7  smooth csplines w l lw 2 title "Zr d_yz",\
  "<(sed -n '5010,9999p' DOSCAR)" u ($1-ef):8  smooth csplines w l lw 2 title "Zr d_3z2",\
  "<(sed -n '5010,9999p' DOSCAR)" u ($1-ef):9 smooth csplines  w l lw 2 title "Zr d_xz",\
  "<(sed -n '5010,9999p' DOSCAR)" u ($1-ef):10  smooth csplines w l lw 2 title "Zr d_x2-y2"
set key right
p "<(sed -n '320071,325070p' DOSCAR)" u ($1-ef):2  smooth csplines w l lw 2 title "C s",\
  "<(sed -n '320071,325070p' DOSCAR)" u ($1-ef):3  smooth csplines w l lw 2 title "C p_x",\
  "<(sed -n '320071,325070p' DOSCAR)" u ($1-ef):4  smooth csplines w l lw 2 title "C p_y",\
  "<(sed -n '320071,325070p' DOSCAR)" u ($1-ef):5  smooth csplines w l lw 2 title "C p_z"
set yrange [0:200]
set ylabel "DOS (states/64atoms)"
plot "DOSCAR" u ($1-ef):2 every ::2500::5000 smooth csplines w l lw 2 title "Total DOS"
unset multiplot


pause -1
