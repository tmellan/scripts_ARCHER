#!/bin/bash

dir=`pwd`
dirList=`echo low_2x2x2sc_400eV_2x2x2kp_EDIFF1E-2_t*`
c=0

for i in $dirList; do 
  cd $i/4.759Ang_3600K
  for j in `echo lambda*/`; do 
    let c=c+1
    cd $j
    
    sise=$(ls -al OUTCAR | awk '{print $5}')

    if [ $sise -ge 100  ]; then
      echo "done already"
        else
      echo yes && cp $dir/prun.pbs . && qsub prun.pbs && sleep 500 && wait
    fi

    pwd
    cd $dir/$i/4.759Ang_3600K/

  done
  cd $dir
done 
