#!/bin/bash

echo a1 b2 c3 trace > trace_alatt
for i in {0..1958}; do 
  let k=$(echo 52*$i+3 | bc -l)  
  let j=k+1 
  let l=j+1 
  alat1=$(sed -n ''$k'p' XDATCAR | awk '{print $1}')  
  blat2=$(sed -n ''$j'p' XDATCAR | awk '{print $2}')  
  clat3=$(sed -n ''$l'p' XDATCAR | awk '{print $3}')  
  trace=$(echo "scale=9; $alat1*$blat2*$clat3" | bc -l)
  echo $alat1 $blat2 $clat3 $trace >> trace_alatt
done
echo head 
head trace_alatt
echo tail 
tail trace_alatt
