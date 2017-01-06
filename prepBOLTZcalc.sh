#!/bin/bash
id="f"
list=`echo 4*`
dir=`pwd`

for i in $list; do 
  cd $i
  cp ../SP_SUBMIT/INCARsmall INCAR
  cp ../SP_SUBMIT/KPOINTSsmall KPOINTS
  cp ../SP_SUBMIT/POTCAR .
  cp ../SP_SUBMIT/POSCAR .
  cp ../SP_SUBMIT/prun.pbs .
  

  sig=$(echo $i | tail -c4)
  alat1=$(echo $i | head -c4 | tail -c3)
  alat2=$(echo 4.$alat1)
  alat3=$(echo $alat2*2 | bc -l)
  name=$(echo $i | head -c5)

  sed -i 's/xxxSIGMAxxx/0.'$sig'/g' INCAR
  sed -i 's/xxxALATxxx/'$alat3'/g' POSCAR
  sed -i 's/xxxNAMExxx/'$name''$id'/g' prun.pbs 
 
  cd $dir
done  
