#!/bin/bash
#list1="4.685Ang_760K 4.685Ang_1900K 4.685Ang_2500K 4.685Ang_3200K 4.685Ang_3805K"
list2="4.801Ang_760K 4.801Ang_1900K 4.801Ang_2500K 4.801Ang_3200K 4.801Ang_3805K"


for i in $list2; do 
  cd $i 
  grep "F" OSZICAR | awk '{print $3}' > T.dat
  grep "F" OSZICAR | awk '{print $5}' > E.dat
  paste T.dat E.dat > TE1.dat
  cd ../
done

cat>plotfile<<!
glist1="4.685Ang_760K/TE1.dat 4.685Ang_1900K/TE1.dat 4.685Ang_2500K/TE1.dat 4.685Ang_3200K/TE1.dat 4.685Ang_3805K/TE1.dat"
glist2="4.801Ang_760K/TE1.dat 4.801Ang_1900K/TE1.dat 4.801Ang_2500K/TE1.dat 4.801Ang_3200K/TE1.dat 4.801Ang_3805K/TE1.dat"
set term x11 0
set title "Temperature (K)"
plot for [list in glist1] list u 1 w l title list

set term x11 1
set title "F (eV/cell)"
plot for [list in glist1] list u 2 w l title list
!
gnuplot -persist plotfile
