#!/bin/bash

grep "F" OSZICAR | awk '{print $3}' > T.dat
grep "F" OSZICAR | awk '{print $5}' > E.dat

paste T.dat E.dat > TE1.dat

cd SECOND_run
grep "F" OSZICAR | awk '{print $3}' > T.dat
grep "F" OSZICAR | awk '{print $5}' > E.dat
paste T.dat E.dat > ../TE2.dat
cd ../

cat TE1.dat TE2.dat > allTE.dat

cat>plotfile<<!

set term x11 0
set title "Temp (K) vs 3fs time-step (24HR X2, 4.850A, 3805K, 444KP, 700EN)"
plot "allTE.dat" u 1 w l title "Temp (K)"

set term x11 1

set title "F (eV/cell) vs 3fs time-step (24HR X2, 4.850A, 3805K, 444KP, 700EN)"
plot "allTE.dat" u 2 w l title "F (eV/cell)"


!

#cat>plotfile<<!
#
#set term x11
#
#plot "TE.dat" u 1 w l title "Temp (K)"
#plot "TE.dat" u 2 w l title "F (eV/cell)"
#
#
#!
#gnuplot -persist plotfile
gnuplot -persist plotfile
