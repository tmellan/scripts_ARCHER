#!/bin/bash
alatt=`sed -n '3,3p' XDATCAR  | awk '{printf "%1.5f", $1}'`
vac_site1=$(tail -n 1 POSCAR | awk '{print $1}')
vac_site2=$(tail -n 1 POSCAR | awk '{print $2}')
vac_site3=$(tail -n 1 POSCAR | awk '{print $3}')

for i in {1..2830}; do
  echo $(echo $alatt*$vac_site1 | bc -l) $(echo $alatt*$vac_site2 | bc -l) $(echo $alatt*$vac_site3 | bc -l)
done > tmp1

paste <(cat tmp1) <(cat def_traj_cart_periodic) > tmp2
awk '{$13=$4-$1}'1 tmp2 > tmp3
awk '{$14=$5-$2}'1 tmp3 > tmp4
awk '{$15=$6-$3}'1 tmp4 > tmp5
awk '{$16=$13*$13+$14*$14+$15*$15}'1 tmp5 > tmp6
awk '{print $13, $14, $15, $16**0.5}' tmp6 > vacInterDist_xyz_r.dat
rm tmp*


echo ****************** DONE ***********************
head vacInterDist_xyz_r.dat && tail vacInterDist_xyz_r.dat
