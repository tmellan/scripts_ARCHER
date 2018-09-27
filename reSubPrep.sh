#!/bin/bash


dir=`pwd`

for i in  `echo lambda*`; do
  cd $i
  rm CONTCAR DOSCAR CHG* EIGENVAL IBZKPT OUTCAR PCDAT XDATCAR forces* log* dUdL input energy pwdd.out vasprun.xml
  s=`date +%N | awk '{printf "%7d",$1%942438976}'`
  oldSeed=$(grep 'SEED' INCAR  | awk '{print $3}')
  sed -i 's|'$oldSeed'|'$s'|' INCAR  
  echo ""
  echo $i
  echo ""
  cat INCAR
  cd $dir
done
