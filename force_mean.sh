list="1T760 2T1900 3T2500 4T3200 5T3805"
var=50  #caclulate mean from 50th position onwards
dir=`pwd`
rm  mean

for i in $list; do
  cd $i 
  vef.py &&
  sed '1,'$var''d fe.dat | awk -v N=2 '{ sum += $N } END { if (NR > 0) print sum / NR }' >> ../mean
#  echo $i >> ../name
  cd $dir
done

paste name mean > rms_forces

echo "rms forces done"

cat > plotfile_msd_forces <<!

set term pdf linewidth 2
set output "MSD_forces.pdf"
set key bottom
set title "3200K ion temperature MD \n with electronic temperature 760/1900/2500/3200/3805 K"
set xlabel "1 fs timestep"
set ylabel "RMS force (eV/Ang)"
p "1T760/fe.dat" u 1:2 w l, "2T1900/fe.dat" u 1:2 w l, "3T2500/fe.dat" u 1:2 w l, "4T3200/fe.dat" u 1:2 w l, "5T3805/fe.dat" u 1:2 w l

!

echo " first plot done"

cat > plotfile_meanmsd_forces <<!

set term pdf linewidth 2
set output "meanMSD_forces.pdf"
set title "3200K ion temperature MD \n with electronic temperature 760/1900/2500/3200/3805 K"
set xlabel "Temp (K)"
set ylabel "Mean RMS force (eV/Ang)"
p "rms_forces" u 1:2 w l

!

echo "second plot done"

gnuplot plotfile_meanmsd_forces
gnuplot plotfile_msd_forces

echo "opening plots"

gnome-open meanMSD_forces.pdf
gnome-open MSD_forces.pdf
