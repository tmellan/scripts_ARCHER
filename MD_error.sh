#/bin/bash

l=`echo Rerun_*`
echo $l
dir=`pwd`
for i in $l; do
  cd $i
  reference_E=$(grep "F=" OSZICAR | tail -1 | awk '{print $5}')
  echo 1 2 3 4 5 6 7 8 9 10 11 12 > no.dat
  echo "N E E/N Sum(E) Mean(E) E^2 E^2/N Sum(E^2) Mean(E^2) Variance SD Mean-SD" > name.dat 
  echo $reference_E
  awk -v ref="$reference_E" 'BEGIN{i=1}
                { E[i]=($2) ; EperN[i]=(E[i])/(i-1.0000001) ; Sum_E[i]=(E[i])+Sum_E[i-1] ; Av_E[i]=Sum_E[i]/(i-1.000000001) ; sq_E[i]=$2*$2 ; sq_EperN[i]=sq_E[i]/(i-1.000000001) ; Sum_sq_E[i]=sq_E[i]+Sum_sq_E[i-1] ; Av_sq_E[i]=Sum_sq_E[i]/(i-1.000000001) ; var[i]=Av_sq_E[i]-(Av_E[i]*Av_E[i]) ; sd[i]=var[i]**0.5 ; dif[i]=(Av_E[i]-sd[i]) ; i=i+1} \
       END{for (j=0;j<i;j++) print j-1, E[j]-'ref', EperN[j]-'ref', Sum_E[j], Av_E[j]-'ref', sq_E[j], sq_EperN[j], Sum_sq_E[j], Av_sq_E[j], var[j], sd[j], dif[j]}' allMD.dat > tmp
  sed '1,2d' tmp | column -t > tmp2
  cat name.dat tmp2 name.dat | column -t > etotal.err
#  rm tmp2 tmp
  head ../$i/etotal.err ../$i/allMD.dat tmp
cat>plotfile_$i<<!

set term pdf
set output "etotal.$i.pdf"
set title "Etotal for $i"
set y2tics
set yrange [-15:15]
set key outside
set xlabel "Nth 3fs step"
set ylabel "Etotal = f+thermostat (eV/64atom)"
set termoption dash
plot "etotal.err" u 1:2 w l lw 1 lc 3 lt 1 title "Etotal", "" u 1:5 w l lw 3 lc 4 lt 1 title "Etotal Mean", "" u 1:11 w l lw 3 lc 1 lt 1 title "Etotal SD"

!
  gnuplot -persist plotfile_$i
  cd ../
done

for i in $l; do 
  gnome-open $i/etotal.$i.pdf
done
