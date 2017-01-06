#!/bin/bash
#list1="4.685Ang_760K 4.685Ang_1900K 4.685Ang_2500K 4.685Ang_3200K 4.685Ang_3805K"
#list2="4.801Ang_760K 4.801Ang_1900K 4.801Ang_2500K 4.801Ang_3200K 4.801Ang_3805K 3Rerun_4.801Ang_3805K"
lista="1T760 2T1900 3T2500 4T3200 5T3805"

for i in $lista; do 
  cd $i 
  grep "F" OSZICAR | awk '{print $3}' > T.dat
  grep "F" OSZICAR | awk '{print $5}' > E.dat
  grep "F" OSZICAR | awk '{print $7}' > F.dat
  grep "F" OSZICAR | awk '{print $9}' > E0.dat
  grep "F" OSZICAR | awk '{print $9}' > Ek.dat
  paste T.dat E.dat F.dat E0.dat Ek.dat > allMD.dat
  cd ../
done

cat>plotfile<<!
glist1="4.685Ang_760K/allMD.dat 4.685Ang_1900K/allMD.dat 4.685Ang_2500K/allMD.dat 4.685Ang_3200K/allMD.dat 4.685Ang_3805K/allMD.dat"
glist2="4.801Ang_760K/TE1.dat 4.801Ang_1900K/TE1.dat 4.801Ang_2500K/TE1.dat 4.801Ang_3200K/allMD.dat 4.801Ang_3805K/allMD.dat 3Rerun_4.801Ang_3805K/allMD.dat"

glista="1T760/allMD.dat 2T1900/allMD.dat 3T2500/allMD.dat 4T3200/allMD.dat 5T3805/allMD.dat"

set term x11 0
set title "Temperature (K)"
plot for [list in glista] list u 1 w l title list

set term x11 1
set key bottom
set title "Etot=F+thermostat (eV/cell) vs step (3fs), \n for alatt=4.685 and T=760K \n and Tel={760K,1900K,2500K,3200K,3805K}"
plot for [list in glista] list u 2 w l lw 2 title list

set term x11 2
set key bottom
set title "F=E0-TSel (eV/cell) vs step (3fs), \n for alatt=4.685 and T=760K \n and Tel={760K,1900K,2500K,3200K,3805K}"
plot for [list in glista] list u 3 w l lw 2 title list

set term x11 3
set key bottom
set title "E0 (eV/cell) vs step (3fs), \n for alatt=4.685 and T=760K \n and Tel={760K,1900K,2500K,3200K,3805K}"
plot for [list in glista] list u 4 w l lw 2 title list

set term x11 4
set key bottom
set title "Ekinetic (eV/cell) vs step (3fs), \n for alatt=4.685 and T=760K \n and Tel={760K,1900K,2500K,3200K,3805K}"
plot for [list in glista] list u 5 w l lw 2 title list

!
gnuplot -persist plotfile
