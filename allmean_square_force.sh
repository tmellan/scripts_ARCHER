#!/bin/bash

list=`echo *_*/`

for j in $list; do
  cd $j
  pwd
  c=0;let c=c+1

  rm index tmp1 tmp2 tmp3

  for i in {1..64}; do 
    echo $i >> index
  done

  tail -118 OUTCAR | head -64 | awk '{print ($1*$1 + $2*$2 +$3*$3)**0.5,( $4*$4+$5*$5+$6*$6)**0.5}' |column -t > tmp1
  paste index tmp1 > tmp2

  mean=`awk '{ sum += $3; n++ } END { if (n > 0) print sum/64; }' tmp2`

  for i in {1..64} ; do 
    echo $mean >> tmp3
  done

  paste tmp2 tmp3 | column -t  > position_force_mean_square

cat>plotfile<<!
set term pdf
set output "$c.upsample_force_rms.pdf"
set xlabel "atom (1..64)"
set ylabel "Force (eV/Ang)"
set title "Config $c $j RMS force"
plot "position_force_mean_square" u 1:3 title "RMS force", "" u 1:4 w l lw 3 title "Mean RMS force"
!

gnuplot -persist plotfile

  cd ../
done

#gnome-open */*.upsample_force_rms.pdf
