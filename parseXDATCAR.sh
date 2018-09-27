#!/bin/bash

dir=`pwd`

#Split the file
head -n 7 XDATCAR > head.xdatcar
tail -n +8 XDATCAR > nohead.xdatcar

cdir=`basename $dir`
echo "Set sample size proportional to correlation length of sample size"
case "$cdir" in 
  '2000') echo "Temp is 2000K, 2tau/deltaT = 33" && sampleSize="33" ;; 
  '1500') echo "Temp is 1500K, 2tau/deltaT = 50" && sampleSize="50" ;;
  '1000') echo "Temp is 1000K, 2tau/deltaT = 66" && sampleSize="66" ;;
  '500') echo "Temp is 500K, 2tau/deltaT = 100" && sampleSize="100" ;;
esac


#Define some parameters
nStepTotal=$(grep T= OSZICAR | tail -n 1 | awk '{print $1}')
preEquilibriationSize=300
#Floor division rounds up
nStepStart=$(echo $preEquilibriationSize/$sampleSize +1 | bc)
nStepEnd=$(echo $preEquilibriationSize/$sampleSize +15 | bc)

if [ $nStepTotal -le $(echo $preEquilibriationSize +15*$sampleSize | bc) ]; then echo PROBLEM, RUN TOO SHORT ; else echo "SUFFICIENT DATA TO SAMPLE"; fi

#If directory structure doesn't exist make it
if [ ! -d UP-samples ]; then
  mkdir UP-samples ; cd UP-samples ; mkdir raw ; mkdir  poscars ; cd $dir 
fi

#Extract samples, excluding a pre-eq period
c=0
for i in `seq $nStepStart $nStepEnd`; do
  let c=c+1
  configStart=$(echo $i*129-128 | bc -l)
  configEnd=$(echo $i*129 | bc -l)
  echo $c $i $configStart $configEnd
  sed -n ''$configStart', '$configEnd'p' nohead.xdatcar > UP-samples/raw/$c.$i.$configStart.poscar
  cat <(cat head.xdatcar) <(sed -n ''$configStart', '$configEnd'p' nohead.xdatcar | tail -n +2) > UP-samples/poscars/$c.POSCAR
done
