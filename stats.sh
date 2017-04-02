#!/bin/bash

# SD : sd=$(awk -v N=4 '{sum+=$N; array[NR]=$N} END {for(x=200;x<=NR;x++){sumsq+=((array[x]-(sum/NR))**2);}print sqrt(sumsq/NR)}'  trace_alatt)
# ACCURACY : accuracy=$( awk -v N=4 '{sum+=$N; array[NR]=$N} END {for(x=200;x<=NR;x++){sumsq+=((array[x]-(sum/NR))**2);}print sqrt(sumsq/NR)/sqrt(NR)}'  trace_alatt)
# MEAN : mean=$(awk -v N=4 '{ sum += $N } END { if (NR > 0) print sum / NR }' trace_alatt)

echo stats  a b c vol > head.tmp

echo mean > side.tmp
echo sd >> side.tmp
echo accuracy >> side.tmp

for i in {1..4}; do 

  sd=$(awk -v N=$i '{sum+=$N; array[NR]=$N} END {for(x=200;x<=NR;x++){sumsq+=((array[x]-(sum/NR))**2);}print sqrt(sumsq/NR)}'  trace_alatt)
  accuracy=$( awk -v N=$i '{sum+=$N; array[NR]=$N} END {for(x=200;x<=NR;x++){sumsq+=((array[x]-(sum/NR))**2);}print sqrt(sumsq/NR)/sqrt(NR)}'  trace_alatt)
  mean=$(awk -v N=$i '{ sum += $N } END { if (NR > 200) print sum / NR }' trace_alatt)
 
  echo $mean > out.$i.tmp
  echo $sd >> out.$i.tmp
  echo $accuracy >> out.$i.tmp

done

paste side.tmp out.1.tmp out.2.tmp out.3.tmp out.4.tmp > data.tmp

cat head.tmp data.tmp | column -t  > stats.out
rm *.tmp
cat stats.out

