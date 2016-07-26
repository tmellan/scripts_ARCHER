#!/bin/bash
dir=`pwd`

MAX=$(grep T= OSZICAR | tail -n 1 | awk '{print $1}')
MIN=$(($MAX-225))
echo $MAX $MIN > MAXMIN

rm -r UP_sample
mkdir UP_sample

c=0
TEMP=$(grep "TEBEG  =" INCAR | awk '{print $3}')
for(( i=$MIN; i <= $MAX; i=i+15 )); do
  echo $i
  let c=c+1
  mkdir $dir/UP_sample/$c
sed -e 's/#PBS -N XXNAMEXX/#PBS -N '$TEMP'_'$c'/g' ../SUBMISSION_STUFF/prun.pbs > $dir/lambda$L/proc/config$i/prun.pbs
  cp ../SUBMISSION_STUFF/* $dir/UP_sample/$c && cp PDF_ANALYSIS_vasprun/POSCAR$i $dir/UP_sample/$c/
  cp $dir/UP_sample/$c/POSCAR$i $dir/UP_sample/$c/POSCAR
done
