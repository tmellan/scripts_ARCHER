#!/bin/bash
#########################################################################
# Script to read thermodynamic integration output
# MOve the TI output to a UP-sampling directory
# In up-sampling directory prep scripts and files required for UP-sampling
# Run the random_config.sh script
#########################################################################

#done already 4.685Ang_760K removed from l

v1="4.685Ang_1900K 4.685Ang_2500K 4.685Ang_3200K 4.685Ang_3805K"
v2="4.730Ang_1900K 4.730Ang_2500K 4.730Ang_3200K 4.730Ang_3805K 4.730Ang_760K"
v3="4.759Ang_1900K 4.759Ang_2500K 4.759Ang_3200K 4.759Ang_3805K 4.759Ang_760K"
v4="4.801Ang_1900K 4.801Ang_2500K 4.801Ang_3200K 4.801Ang_3805K 4.801Ang_760K"
v5="4.850Ang_1900K 4.850Ang_2500K 4.850Ang_3200K 4.850Ang_3805K 4.850Ang_760K"
l=$v5
head="headv5"



#l="4.685Ang_1900K 4.685Ang_2500K 4.685Ang_3200K 4.685Ang_3805K 4.730Ang_1900K 4.730Ang_2500K 4.730Ang_3200K 4.730Ang_3805K 4.730Ang_760K 4.759Ang_1900K 4.759Ang_2500K 4.759Ang_3200K 4.759Ang_3805K 4.759Ang_760K 4.801Ang_1900K 4.801Ang_2500K 4.801Ang_3200K 4.801Ang_3805K 4.801Ang_760K 4.850Ang_1900K 4.850Ang_2500K 4.850Ang_3200K 4.850Ang_3805K 4.850Ang_760K "
dir=`pwd`
lam="0.0 0.15 0.5 0.85 1.0"


echo in directory $dir at `date`

for i in $l; do
  cp -r test_EAM_UPTILD/$i . && cd $i && mkdir UP-SAMPLE &&
  echo coped $i to $dir and made the directory UP-SAMPLE inside $i

  for j in $lam; do 
    mv lambda$j UP-SAMPLE/. &&
    echo moved lamda$j to $i/UP-SAMPLE/
  done &&
  echo DONE MOVING all lamdas into $i/UP-SAMPLE/
 
  cd $dir && cp -r $head out.rand_configs random_config.sh submit_UP_all_lambda.sh $i/UP-SAMPLE/. && cd $i/UP-SAMPLE && mv $head high_input && ./random_config.sh &&
  echo coped input scripts to $i/UP-SAMPLE/ and ran random_config.sh
  cd $dir
  echo changed directory back to $dir
done

echo DONE at `date`
  

  

