#!/bin/bash

t=300
a=4.685

cat>plotfile<<!
set term pdf
set output "msd_$t_$a.pdf"
set title "Mean square displacement for MD at T=$t K and a=$a Ang" 
set xlabel "3 fs timestep"
set ylabel "Mean square displacement (Angstrom^2)"
plot "msd.out" u 1:2 w l title "Total MSD", "" u 1:3 w l title "config MSD", "" u 1:5 w l title "col 5 ", "" u 1:6 w l title "col 6"
!

gnuplot -persist plotfile

gnome-open msd_$t_$a.pdf
