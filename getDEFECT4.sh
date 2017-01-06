#!/bin/bash

############################################################################
#Pick out the trajectory to plot for a defect atom in an MD run, swapping to Cartesian coords and taking care of periodicity

#In this example pick out the follow defective atoms:
#INTERSITITIAL atom 64 : 0.075448997         0.132124007         0.370765001
#trimer part 1 atom 41 :  0.0110128300         0.028503999         0.277350008
#timer part 1 atom 37 : 0.0110128300         0.225538999         0.474384993
#trimer part2 atom 53 :   0.259822011         0.989409983         0.513478994 
#############################################################################

maxval="2830"
limit=0.8000
#get lattice parameter
alatt=`sed -n '3,3p' XDATCAR  | awk '{printf "%1.5f", $1}'`
limitlatt=`echo "scale=3; $alatt*$limit " | bc -l`
#remove lattice parameter lines from trajectory file
sed '1,7d' XDATCAR > xdat
#Separate the trajectory for the defect atom
for i in {1..2830}; do var=`echo "scale=3; $i*66-1" | bc -l` ; sed -n ''$var','$var'p' xdat ; done | column -t > def_traj_dir_1
#Separate the trajectory for the defect atom2
for i in {1..2830}; do var=`echo "scale=3; $i*66-24" | bc -l` ; sed -n ''$var','$var'p' xdat ; done | column -t > def_traj_dir_2
#Separate the trajectory for the defect atom3
for i in {1..2830}; do var=`echo "scale=3;$i*66-12" | bc -l` ; sed -n ''$var','$var'p' xdat ; done | column -t > def_traj_dir_3
#Put the defect trajectories together like like atom_1_x atom_1_y ... in 9 colums
paste def_traj_dir_1 def_traj_dir_2 def_traj_dir_3 > def_traj_dir
#Convert the direct coordinates to Cartesian and 
awk '{printf "%4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f\n", $1*'$alatt', $2*'$alatt', $3*'$alatt', $4*'$alatt', $5*'$alatt', $6*'$alatt', $7*'$alatt', $8*'$alatt', $9*'$alatt'}' def_traj_dir | column -t   > def_traj_cart

#Sort out periodicity
cp def_traj_cart tmp
for j in {1..9}; do 
  for i in {1..2830}; do
    v1=`sed -n ''$i','$i'p' def_traj_cart | awk '{print $'$j'}'`
    if (( $(echo "scale=3 ; $v1 > $limitlatt" |bc -l) )); then
      v2=`echo "scale=3 ; $v1 - $alatt" | bc -l` && sed -i 's/'$v1'/'$v2'/g' tmp
    fi
    echo $v1  $v2
  done
done
awk '{print $1, $2, $3, $4, $5, $6, $7, $8, $9}' tmp | column -t > def_traj_cart_periodic && rm tmp
