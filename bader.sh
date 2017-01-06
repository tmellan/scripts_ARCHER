#!/bin/bash

dir=`pwd`
#list=`echo */SP_*`
list="4685_SP_COND_252525 4730_SP_COND_252525 4759_SP_COND_252525 4801_SP_COND_252525 4850_SP_COND_252525"

for i in $list; do 
  cd $i
  cd SP_perfect/
  chgsum.pl AECCAR0 AECCAR2 && bader CHGCAR -ref CHGCAR_sum
  echo done $i SP_perfect
  cd ../SP/
  chgsum.pl AECCAR0 AECCAR2 && bader CHGCAR -ref CHGCAR_sum
  cd ../
  paste SP/ACF.dat SP_perfect/ACF.dat | awk '{$15=$5-$12}'1 | column > comparison_bader
  cat comparison_bader
  cd $dir
done
