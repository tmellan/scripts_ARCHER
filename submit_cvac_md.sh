#!/bin/bash

dir=`pwd`
vols="9.370 9.460 9.518 9.602 9.700"
alatts="4.685 4.730 4.759 4.801 4.850"
temps="737 1900 2508 3224 3858"
arr=($temps) 
c=-1

for i in $alatts; do 
  mkdir $i 
  cd $i 

  let c=c+1
  T=`echo ${arr[c]}`

  sed -e 's/XXNAMEXX/'$i'.'$T'/g' ../SUBSTUFF/prun.pbs > prun.pbs

  cp ../cvac_rear_POSCARs/'1.cvac.'$i'a.POSCAR.reorder' POSCAR
#  sed -e 's/XX2ALATTXX/'$i'/g' ../SUBSTUFF/POSCAR > POSCAR

  s=`date +%N | awk '{printf "%7d",$1%942438976}'`
  sed -e 's/XXTEMPXX/'$T'/g' ../SUBSTUFF/INCAR > INCAR  
  sed -i 's/XXSEEDXX/'$s'/g' INCAR

  cp ../SUBSTUFF/POTCAR ../SUBSTUFF/KPOINTS .
  pwd &&  echo $T
#  pwd && cat INCAR prun.pbs KPOINTS && head POSCAR
  cd $dir
done
echo done
