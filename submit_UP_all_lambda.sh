#!/bin/bash

l="31 97 24 46 83"
#l="31 97"
dir=`pwd`
L="1.0"
cd $dir && cd ../ && ENDDIR=`pwd | sed 's#.*/##' | sed 's/[^0-9]*//g'` && cd $dir && echo in the directory string $ENDDIR

echo directory lambda$L submissions for configs{...$l...} for lat-temp string $ENDDIR, which has been shortened to ${ENDDIR:5} for the qsub name, started at `date` > $L.note

for i in $l; do
  cd $dir/lambda$L/proc/config$i && echo in the directory called lambda$L/proc/config$i
  sed -e 's/#PBS -N XXNAMEXX/#PBS -N '${ENDDIR:5}'_'$L'_'$i'/g' ../../../../../prun.pbs > $dir/lambda$L/proc/config$i/prun.pbs
  qsub prun.pbs >> $L.note && echo config$i submitted at `date` >> $L.note 
  cd $dir && echo submitted config$i
  echo config$i submitted at `date` >> $L.note
done
echo DONE 


