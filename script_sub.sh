#!/bin/bash

aldir="4.685Ang 4.730Ang 4.759Ang 4.801Ang 4.850Ang"

#aldir="4.759Ang 4.801Ang 4.850Ang"
dir=`pwd`
for i in $aldir; do
  cd $i 
  mkdir SECOND_run
  cp INCAR POSCAR CONTCAR POTCAR KPOINTS SECOND_run
  cp ../prunlong.pbs SECOND_run/prun.pbs
  cd SECOND_run
  cp CONTCAR POSCAR
  qsub prun.pbs
  cd $dir
done


