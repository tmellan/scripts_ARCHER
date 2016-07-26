#!/bin/bash
dir=`pwd`

MAX=$(grep T= OSZICAR | tail -n 1 | awk '{print $1}')
MIN=$(($MAX-200))
echo $MAX $MIN > MAXMIN

rm -r UP_sample
mkdir UP_sample

c=0
ENDDIR=`pwd | sed 's#.*/##' | sed 's/[^0-9]*//g'`
TEMP=$(grep "TEBEG  =" INCAR | awk '{print $3}')
TEL=`grep "SIGMA  =    " INCAR |awk '{print $3}'`
for(( i=$MIN; i <= $MAX; i=i+30 )); do
  echo $i
  let c=c+1
  mkdir $dir/UP_sample/$c
  sed -e 's/#PBS -N XXNAMEXX/#PBS -N '$ENDDIR'_'$c'/g' ../SUBMISSION_stuff_cx1/cx1run.pbs.16 > $dir/UP_sample/$c/cx1run.pbs.16
  sed -e 's/SIGMA  =    XXXTELXXX/SIGMA  =   '$TEL'/g' ../SUBMISSION_stuff_cx1/INCAR > $dir/UP_sample/$c/INCAR
  cp ../SUBMISSION_stuff_cx1/KPOINTS $dir/UP_sample/$c/.
  cp PDF_ANALYSIS_vasprun/POSCAR$i $dir/UP_sample/$c/.
  cp $dir/UP_sample/$c/POSCAR$i $dir/UP_sample/$c/POSCAR
done
echo over
