#!/bin/bash

l="31 97 24 46 83"
dir=`pwd`
L=1.0

echo directory lambda$L submissions started at `date` > $L.note

for i in $l; do
  cd lambda$L/proc/config$i && echo in the directory called lambda$L/proc/config$i
  qsub prun.pbs && echo config$i submitted at `date` >> $L.note 
  cd $dir && echo submitted config$i
  echo config$i submitted at `date` >> $L.note
done
echo DONE 


