#!/bin/bash
Natoms=32
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
  for ((i=1; i<=$maxval; i++)); do var=`echo "scale=3; $i*65-$j" | bc -l` ; sed -n ''$var','$var'p' xdat ; done | column -t > def_traj_dir_$j
done

paste def_traj_dir_{1..32} > def_traj_dir

#awkone=$(echo '{printf " ')
#awktwo=$(for i in {1..96}; do echo "%4.4f" ; done)
#awkthree=$(echo '\n", ')
#awkfour=$(for i in {1..96}; do echo '$'$i'*'$alatt'' ; done)
#awkfive=$(echo '}')
#awkall=$(echo $awkone $awktwo $awkthree $awkfour $awkfive)
awk '{printf " %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f \n" , $1*9.62461 , $2*9.62461 , $3*9.62461 , $4*9.62461 , $5*9.62461 , $6*9.62461 , $7*9.62461 , $8*9.62461 , $9*9.62461 , $10*9.62461 , $11*9.62461 , $12*9.62461 , $13*9.62461 , $14*9.62461 , $15*9.62461 , $16*9.62461 , $17*9.62461 , $18*9.62461 , $19*9.62461 , $20*9.62461 , $21*9.62461 , $22*9.62461 , $23*9.62461 , $24*9.62461 , $25*9.62461 , $26*9.62461 , $27*9.62461 , $28*9.62461 , $29*9.62461 , $30*9.62461 , $31*9.62461 , $32*9.62461 , $33*9.62461 , $34*9.62461 , $35*9.62461 , $36*9.62461 , $37*9.62461 , $38*9.62461 , $39*9.62461 , $40*9.62461 , $41*9.62461 , $42*9.62461 , $43*9.62461 , $44*9.62461 , $45*9.62461 , $46*9.62461 , $47*9.62461 , $48*9.62461 , $49*9.62461 , $50*9.62461 , $51*9.62461 , $52*9.62461 , $53*9.62461 , $54*9.62461 , $55*9.62461 , $56*9.62461 , $57*9.62461 , $58*9.62461 , $59*9.62461 , $60*9.62461 , $61*9.62461 , $62*9.62461 , $63*9.62461 , $64*9.62461 , $65*9.62461 , $66*9.62461 , $67*9.62461 , $68*9.62461 , $69*9.62461 , $70*9.62461 , $71*9.62461 , $72*9.62461 , $73*9.62461 , $74*9.62461 , $75*9.62461 , $76*9.62461 , $77*9.62461 , $78*9.62461 , $79*9.62461 , $80*9.62461 , $81*9.62461 , $82*9.62461 , $83*9.62461 , $84*9.62461 , $85*9.62461 , $86*9.62461 , $87*9.62461 , $88*9.62461 , $89*9.62461 , $90*9.62461 , $91*9.62461 , $92*9.62461 , $93*9.62461 , $94*9.62461 , $95*9.62461 , $96*9.62461 }' def_traj_dir | column -t   > def_traj_cart

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
