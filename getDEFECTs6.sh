#!/bin/bash

############################################################################
#Pick out the trajectory to plot for a defect atom in an MD run, swapping to Cartesian coords and taking care of periodicity

#In this example pick out the follow defective atoms:
#INTERSITITIAL atom 64 : 0.075448997         0.132124007         0.370765001
#trimer part 1 atom 41 :  0.0110128300         0.028503999         0.277350008
#timer part 1 atom 37 : 0.0110128300         0.225538999         0.474384993
#trimer part2 atom 53 :   0.259822011         0.989409983         0.513478994 
#############################################################################

#NEW - defect forms at atom 58 - 0.86128033  0.07207756  0.14167502 ie 'use number 59 in script by using 7'
# plus also look at the trajectory for two other random atoms

#1NEW - try 19 20 and 21 from the end for C

maxval="300"
limit=0.90
#get lattice parameter
alatt=`sed -n '3,3p' XDATCAR  | awk '{printf "%1.5f", $1}'`
limitlatt=`echo "scale=3; $alatt*$limit " | bc -l`
#remove lattice parameter lines from trajectory file
sed '1,7d' XDATCAR > xdat
#Separate the trajectory for the defect atom
for j in {1..20}; do 
  for i in {1..3009}; do var=`echo "scale=3; $i*61-$j" | bc -l` ; sed -n ''$var','$var'p' xdat ; done | column -t > def_traj_dir_$j
done

paste def_traj_dir_{1..20} > def_traj_dir

awk '{printf "%4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f\n", $1*'$alatt', $2*'$alatt', $3*'$alatt', $4*'$alatt', $5*'$alatt', $6*'$alatt', $7*'$alatt', $8*'$alatt', $9*'$alatt', $10*'$alatt', $11*'$alatt', $12*'$alatt', $13*'$alatt', $14*'$alatt', $15*'$alatt', $16*'$alatt', $17*'$alatt', $18*'$alatt', $19*'$alatt', $20*'$alatt', $21*'$alatt', $22*'$alatt', $23*'$alatt', $24*'$alatt', $25*'$alatt', $26*'$alatt', $27*'$alatt', $28*'$alatt', $29*'$alatt', $30*'$alatt', $31*'$alatt', $32*'$alatt', $33*'$alatt', $34*'$alatt', $35*'$alatt', $36*'$alatt', $37*'$alatt', $38*'$alatt', $39*'$alatt', $40*'$alatt', $41*'$alatt', $42*'$alatt', $43*'$alatt', $44*'$alatt', $45*'$alatt', $46*'$alatt', $47*'$alatt', $48*'$alatt', $49*'$alatt', $50*'$alatt', $51*'$alatt', $52*'$alatt', $53*'$alatt', $54*'$alatt', $55*'$alatt', $56*'$alatt', $57*'$alatt', $58*'$alatt', $59*'$alatt', $60*'$alatt'}' def_traj_dir | column -t   > def_traj_cart

#Sort out periodicity
cp def_traj_cart tmp

for j in {1..60}; do 
  for i in {1..3009}; do
    v1=`sed -n ''$i','$i'p' def_traj_cart | awk '{print $'$j'}'`
    if (( $(echo "scale=3 ; $v1 > $limitlatt" |bc -l) )); then
      v2=`echo "scale=3 ; $v1 - $alatt" | bc -l` && sed -i 's/'$v1'/'$v2'/g' tmp
    fi
    echo $v1  $v2
  done
done


a=$(for i in {1..60}; do echo '$'$i',' ; done)
awk '{print $a}' tmp | column -t > def_traj_cart_periodic && rm tmp
#splot "def_traj_cart_periodic" u 1:2:3 w l, "" u 4:5:6 w l, "" u 7:8:9 w l, "" u 10:11:12 w l, "" u 13:14:15 w l, "" u 16:17:18 w l, "" u 19:20:21 w l, "" u 22:23:24 w l, "" u 25:26:27 w l, "" u 28:29:30 w l, "" u 31:32:33 w l, "" u 34:35:36 w l, "" u 37:38:39 w l, "" u 40:41:42 w l, "" u 43:44:45 w l, "" u 46:47:48 w l, "" u 49:50:51 w l, "" u 52:53:54 w l, "" u 55:56:57 w l, "" u 58:59:60 w l

#Command to get plotting lists gnu=$(for i in {1..20}; do a=$(echo 3*$i-2 | bc -l) ; b=$(echo 3*$i-1 | bc -l) ;c=$(echo 3*$i | bc -l) ; echo '"" u '$a':'$b':'$c', ' ; done)
