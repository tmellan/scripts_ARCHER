#!/bin/bash

eV2meVat=$(echo "scale=9; 1000/64" | bc -l )
#volumes="4685a 4730a 4759a 4801a 4850a"
#volumes="4685 4730 4759 4801 4850"
volumes="4850"
names=(4850)
TEMPS="3200 3805"
dir=`pwd`
Up_sample_name="UP-samples"

c=-1
for i in $volumes; do 
  let c=c+1
  fr_ref=$(tail -n 1 PERFECT_ALL/$i'a'.PERFECT/OSZICAR | awk '{printf "%.15g\n", $3}') 
  e0_ref=$(tail -n 1 PERFECT_ALL/$i'a'.PERFECT/OSZICAR | awk '{printf "%.15g\n", $5}') 
  echo $fr_ref

  for j in $TEMPS; do 
    cd ${names[$c]}/$j/$Up_sample_name/
    pwd
    rm  fr_e0 e0 fr

    for k in `echo POSCAR_*`; do 
      tail -n 1 $k/OSZICAR | awk '{print $3, $5}' >> fr_e0
      free=$(tail -n 1 $k/OSZICAR | awk '{printf "%.15g\n", $3}') ; echo "scale=9; $free*$eV2meVat - $fr_ref*$eV2meVat" | bc -l >> fr
      energy=$(tail -n 1 $k/OSZICAR | awk '{printf "%.15g\n", $5}') ; echo "scale=9; $energy*$eV2meVat - $e0_ref*$eV2meVat" | bc -l  >> e0
    done

  cd $dir
  done

done

echo "done getting free and e0"

#Collate results
cd $dir  ; mkdir DFT_RESULTS  ; cd DFT_RESULTS

c=-1
for i in $volumes; do
  let c=c+1
  for j in $TEMPS; do
    cp $dir/${names[$c]}/$j/$Up_sample_name/fr_e0 $dir/DFT_RESULTS/$i.$j.fr_e0
    cp $dir/${names[$c]}/$j/$Up_sample_name/fr $dir/DFT_RESULTS/$i.$j.fr
    cp $dir/${names[$c]}/$j/$Up_sample_name/e0 $dir/DFT_RESULTS/$i.$j.e0
  done
done

#Collate more
list_fr_e0=$(for i in $volumes; do for j in $TEMPS; do echo $i.$j.fr_e0 ; done ; done)
list_fr=$(for i in $volumes; do for j in $TEMPS; do echo $i.$j.fr ; done ; done)
list_e0=$(for i in $volumes; do for j in $TEMPS; do echo $i.$j.e0 ; done ; done)
cat `echo $list_fr` | awk '{print $1}' > cat.fr
paste `echo $list_fr` | awk '{print $1}' > paste.fr
cat `echo $list_e0`  | awk '{print $2}' > cat.e0
paste `echo $list_e0` | awk '{print $2}' > paste.e0

echo "done collating results"


