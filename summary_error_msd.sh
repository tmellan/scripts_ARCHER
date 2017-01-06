#!/bin/bash
a=4.685
list="4.685Ang_300K 4.685Ang_760K 4.685Ang_1900K 4.685Ang_2500K 4.685Ang_3200K 4.685Ang_3805K"
rm *_tempor ZrC_mean_error_$a
for i in $list; do
  awk '{print $11}' $i/Zr.err | tail -2 | head -1  >> zr_error_tempor
  awk '{print $5}' $i/Zr.err | tail -2 | head -1  >> zr_mean_tempor
  awk '{print $11}' $i/C.err | tail -2 | head -1   >> c_error_tempor
  awk '{print $5}' $i/C.err | tail -2 | head -1  >> c_mean_tempor
done

paste temps zr_mean_tempor c_mean_tempor  zr_error_tempor c_error_tempor | column -t > ZrC_mean_error_$a

b=4.801

rm ZrC_mean_error_$b *_tempor
list2="4.801Ang_300K 4.801Ang_760K 4.801Ang_1900K 4.801Ang_2500K 4.801Ang_3200K 4.801Ang_3805K"

for i in $list2; do
  awk '{print $11}' $i/Zr.err | tail -2 | head -1  >> zr_error_tempor
  awk '{print $5}' $i/Zr.err | tail -2 | head -1  >> zr_mean_tempor
  awk '{print $11}' $i/C.err | tail -2 | head -1   >> c_error_tempor
  awk '{print $5}' $i/C.err | tail -2 | head -1  >> c_mean_tempor
done

paste temps zr_mean_tempor c_mean_tempor  zr_error_tempor c_error_tempor | column -t > ZrC_mean_error_$b



cat >msd_mean_plotfile<<!
set term pdf
set output "ZrC_msd_mean.pdf"
set title "ZrC z-projected temporally-averaged MSD"
set key left
set y2tics
set xlabel "Temperature (K)"
set ylabel "MSD (Angstrom^2)"
plot "ZrC_mean_error_4.685" u 1:2 w l lw 3 title "Zr 4.685Ang", "" u 1:3 w l lw 3 title "C 4.685Ang", "ZrC_mean_error_4.801" u 1:2 w l lw 3 title "Zr 4.801Ang", "" u 1:3 w l lw 3 title "C 4.801Ang"
!

cat >msd_sd_plotfile<<!
set term pdf
set y2tics
set output "ZrC_msd_sd.pdf"
set title "ZrC z-projected standard deviation of MSD"
set key left
set xlabel "Temperature (K)"
set ylabel "MSD (Angstrom^2)"
plot "ZrC_mean_error_4.685" u 1:4 w l lw 3 title "Zr 4.685Ang", "" u 1:5 w l lw 3 title "C 4.685Ang", "ZrC_mean_error_4.801" u 1:4 w l lw 3 title "Zr 4.801Ang", "" u 1:5 w l lw 3 title "C 4.801Ang"
!

gnuplot -persist msd_sd_plotfile
gnuplot -persist msd_mean_plotfile

gnome-open ZrC_msd_sd.pdf
gnome-open ZrC_msd_mean.pdf

