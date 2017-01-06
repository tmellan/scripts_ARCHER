#/bin/awk
cp /work/e89/e89/tamellan/scripts_ARCHER/poscar2xyz.py .
cp /work/e89/e89/tamellan/scripts_ARCHER/msd.py .
python poscar2xyz.py 
python msd.py 
mkdir MSD 
cp msd.out MSD/.
l=`echo MSD`
dir=`pwd`
for i in $l; do
  cd $i
  echo 1 2 3 4 5 6 7 8 9 10 11 12 > no.dat
  echo "N E E/N Sum(E) Mean(E) E^2 E^2/N Sum(E^2) Mean(E^2) Variance SD Mean-SD" > name.dat 
  awk 'BEGIN{i=0}
                {N[i]=($1) ; E[i]=$9 ; EperN[i]=E[i]/(i-1.0000001) ; Sum_E[i]=E[i]+Sum_E[i-1] ; Av_E[i]=Sum_E[i]/(i-1.000000001) ; sq_E[i]=$9*$9 ; sq_EperN[i]=sq_E[i]/(i-1.000000001) ; Sum_sq_E[i]=sq_E[i]+Sum_sq_E[i-1] ; Av_sq_E[i]=Sum_sq_E[i]/(i-1.000000001) ; var[i]=Av_sq_E[i]-(Av_E[i]*Av_E[i]) ; sd[i]=var[i]**0.5 ; dif[i]=(Av_E[i]-sd[i]) ; i=i+1} \
       END{for (j=2;j<650;j++) print N[j], E[j], EperN[j], Sum_E[j], Av_E[j], sq_E[j], sq_EperN[j], Sum_sq_E[j], Av_sq_E[j], var[j], sd[j], dif[j]}' msd.out > tmp
  sed '1,2d' tmp | column -t > tmp2
  cat name.dat tmp2 name.dat | column -t > C.err
  rm tmp2 tmp

cat>plotfile_$i<<!

set term pdf
set output "C.$i.pdf"
set title "z-projected mean square displacement (MSD) for $i"
set y2tics
set key outside
set xlabel "Nth 3fs step"
set ylabel "MSD (Angstrom^2)"
#set termoption dash
plot "C.err" u 1:2 w l lw 1 lc 3 lt 1 title "MSD", "" u 1:5 w l lw 3 lc 4 lt 1 title "MSD Mean", "" u 1:11 w l lw 3 lc 1 lt 1 title "MSD SD"

!
  gnuplot -persist plotfile_$i
  cd ../
done

for i in $l; do 
 gnome-open $i/C.$i.pdf
done
