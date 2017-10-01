#!/bin/bash
Natoms=33
vol=$(sed -n 3p POSCAR | awk '{print $1}')
Ndir=$(echo $Natoms*3 | bc -l)
maxval=$(grep T= OSZICAR | tail -n 1 | awk '{print $1}')
limit=0.90
#get lattice parameter
alatt=`sed -n '3,3p' XDATCAR  | awk '{printf "%1.5f", $1}'`
limitlatt=`echo "scale=3; $alatt*$limit " | bc -l`
#remove lattice parameter lines from trajectory file
sed '1,7d' XDATCAR > xdat
#Separate the trajectory for the defect atom
for ((j=1; j<=$Natoms; j++)); do 
  for ((i=1; i<=$maxval; i++)); do var=`echo "scale=3; $i*66-$j" | bc -l` ; sed -n ''$var','$var'p' xdat ; done | column -t > def_traj_dir_$j
done

paste def_traj_dir_{1..32} > def_traj_dir

#awkone=$(echo '{printf " ')
#awktwo=$(for i in {1..96}; do echo "%4.4f" ; done)
#awkthree=$(echo '\n", ')
#awkfour=$(for i in {1..96}; do echo '$'$i'*'$alatt'' ; done)
#awkfive=$(echo '}')
#awkall=$(echo $awkone $awktwo $awkthree $awkfour $awkfive)
awk -v Volume=$vol '{printf " %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f \n" , $1*Volume , $2*Volume , $3*Volume , $4*Volume , $5*Volume , $6*Volume , $7*Volume , $8*Volume , $9*Volume , $10*Volume , $11*Volume , $12*Volume , $13*Volume , $14*Volume , $15*Volume , $16*Volume , $17*Volume , $18*Volume , $19*Volume , $20*Volume , $21*Volume , $22*Volume , $23*Volume , $24*Volume , $25*Volume , $26*Volume , $27*Volume , $28*Volume , $29*Volume , $30*Volume , $31*Volume , $32*Volume , $33*Volume , $34*Volume , $35*Volume , $36*Volume , $37*Volume , $38*Volume , $39*Volume , $40*Volume , $41*Volume , $42*Volume , $43*Volume , $44*Volume , $45*Volume , $46*Volume , $47*Volume , $48*Volume , $49*Volume , $50*Volume , $51*Volume , $52*Volume , $53*Volume , $54*Volume , $55*Volume , $56*Volume , $57*Volume , $58*Volume , $59*Volume , $60*Volume , $61*Volume , $62*Volume , $63*Volume , $64*Volume , $65*Volume , $66*Volume , $67*Volume , $68*Volume , $69*Volume , $70*Volume , $71*Volume , $72*Volume , $73*Volume , $74*Volume , $75*Volume , $76*Volume , $77*Volume , $78*Volume , $79*Volume , $80*Volume , $81*Volume , $82*Volume , $83*Volume , $84*Volume , $85*Volume , $86*Volume , $87*Volume , $88*Volume , $89*Volume , $90*Volume , $91*Volume , $92*Volume , $93*Volume , $94*Volume , $95*Volume , $96*Volume }' def_traj_dir | column -t   > def_traj_cart

#Sort out periodicity
cp def_traj_cart tmp

for ((j=1; j<=$Ndir; j++)); do 
  for ((i=1; i<=$maxval; i++)); do
    v1=`sed -n ''$i','$i'p' def_traj_cart | awk '{print $'$j'}'`
    if (( $(echo "scale=3 ; $v1 > $limitlatt" |bc -l) )); then
      v2=`echo "scale=3 ; $v1 - $alatt" | bc -l` && sed -i 's/'$v1'/'$v2'/g' tmp
    fi
    echo $v1  $v2
  done
done


a=$(for ((i=1; i<=$Ndir; i++)); do echo '$'$i',' ; done)
awk '{print $a}' tmp | column -t > def_traj_cart_periodic && rm tmp

#splot "def_traj_cart_periodic" u 1:2:3 w l, "" u 4:5:6 w l, "" u 7:8:9 w l, "" u 10:11:12 w l, "" u 13:14:15 w l, "" u 16:17:18 w l, "" u 19:20:21 w l, "" u 22:23:24 w l, "" u 25:26:27 w l, "" u 28:29:30 w l, "" u 31:32:33 w l, "" u 34:35:36 w l, "" u 37:38:39 w l, "" u 40:41:42 w l, "" u 43:44:45 w l, "" u 46:47:48 w l, "" u 49:50:51 w l, "" u 52:53:54 w l, "" u 55:56:57 w l, "" u 58:59:60 w l

#Command to get plotting lists gnu=$(for i in {1..32}; do a=$(echo 3*$i-2 | bc -l) ; b=$(echo 3*$i-1 | bc -l) ;c=$(echo 3*$i | bc -l) ; echo '"" u '$a':'$b':'$c', ' ; done)
#gnuplot> plot "def_traj_cart_periodic" u 1:2, "" u 4:5, "" u 7:8, "" u 10:11, "" u 13:14, "" u 16:17, "" u 19:20, "" u 22:23, "" u 25:26, "" u 28:29, "" u 31:32, "" u 34:35, "" u 37:38, "" u 40:41, "" u 43:44, "" u 46:47, "" u 49:50, "" u 52:53, "" u 55:56, "" u 58:59, "" u 61:62, "" u 64:65, "" u 67:68, "" u 70:71, "" u 73:74, "" u 76:77, "" u 79:80, "" u 82:83, "" u 85:86, "" u 88:89,  "" u 91:92, "" u 94:95
