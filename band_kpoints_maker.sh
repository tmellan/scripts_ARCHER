#!/bin/bash
#Make explicit band kpoint paths for HSE calcualtions ,  rather than use linemode

#0.00000  0.50000  0.50000    1 X
#0.00000  0.00000  0.00000    1 G

#0.00000  0.00000  0.00000    1 G
#0.00000  0.50000  0.50000    1 X

#0.00000  0.50000  0.50000    1 X
#0.50000  0.50000  0.50000    1 L

#0.50000  0.50000  0.50000    1 L
#0.00000  0.00000  0.00000    1 G

#X to Gamma
for i in {50..0}; do j=$(echo "scale=9; $i/100" | bc -l) ; echo "0.000" $j "  " $j " 0 "  ; done > p1

#Gamma to X
for i in {0..50}; do j=$(echo "scale=9; $i/100" | bc -l) ; echo "0.000" $j "  " $j " 0 " ; done > p2  

#X to L
for i in {0..50}; do j=$(echo "scale=9; $i/100" | bc -l) ; echo  $j "0.500000  0.500000 0" ; done > p3

#L to G
for i in {50..0}; do j=$(echo "scale=9; $i/100" | bc -l) ; echo  $j "  " $j "  " $j " 0 " ; done >p4

cat p1 p2 p3 p4 | column -t  > kpoint_list
cat kpoint_list
