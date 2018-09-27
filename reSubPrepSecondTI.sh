#!/bin/bash


dir=`pwd`

for i in  `echo lambda*`; do
  cd $i
  rm CONTCAR DOSCAR CHG* EIGENVAL IBZKPT OUTCAR PCDAT XDATCAR forces* log* dUdL input energy pwdd.out vasprun.xml pre_*
  s=`date +%N | awk '{printf "%7d",$1%942438976}'`
  oldSeed=$(grep 'SEED' INCAR  | awk '{print $3}')
  sed -i 's|'$oldSeed'|'$s'|' INCAR  
  echo ""
  echo $i
  echo ""
  cat INCAR
  cd $dir
done
echo "Cleaned up and seed changed"


 for i in `echo lambda0.0_*`; do name=$(grep SEED $i/INCAR | awk '{print $3}') ; echo "Name changed " $i  lambda0.0_$name ;  mv $i  lambda0.0_$name ; done
 for i in `echo lambda0.15_*`; do name=$(grep SEED $i/INCAR | awk '{print $3}') ; echo "Name changed " $i  lambda0.0_$name ; mv $i  lambda0.15_$name ; done
 for i in `echo lambda0.5_*`; do name=$(grep SEED $i/INCAR | awk '{print $3}') ; echo "Name changed " $i  lambda0.0_$name ;  mv $i  lambda0.5_$name ; done
 for i in `echo lambda0.85_*`; do name=$(grep SEED $i/INCAR | awk '{print $3}') ; echo "Name changed " $i  lambda0.0_$name ;  mv $i  lambda0.85_$name ; done
 for i in `echo lambda1.0_*`; do name=$(grep SEED $i/INCAR | awk '{print $3}') ; echo "Name changed " $i  lambda0.0_$name ;  mv $i  lambda1.0_$name ; done
echo "All folder name changes done"
