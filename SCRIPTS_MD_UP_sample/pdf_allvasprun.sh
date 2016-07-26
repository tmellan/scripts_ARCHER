#!/bin/bash

folder=`pwd`
NAME="$folder PDF ZrC 1-5Ang in 0.05 steps for DFT  MD pre-upsample simulation $STEPS steps (3fs)"
DIR=/work/e89/e89/tamellan/scripts_ARCHER/

rm -r PDF_ANALYSIS_vasprun
mkdir PDF_ANALYSIS_vasprun

cp $DIR/poscar2pdf $DIR/extract_POSCARfromMD.py vasprun.xml PDF_ANALYSIS_vasprun

# cat the 'end' onto vasprun.xml automatically ie </modeling>

module loadopenblas anaconda-compute/python3
cd PDF_ANALYSIS_vasprun && echo "</modeling>" >> vasprun.xml && python extract_POSCARfromMD.py vasprun.xml &&

echo done python pymatgen splitting vasprun.xml
sleep 1
#var=`cat nionic_steps`

#make number of ionic steps and automatically detected variable

STEPS=`cat nion`
echo STEPS=$STEPS
for (( i=1; i<=$STEPS; i=i+5)); do 
  ./poscar2pdf POSCAR$i 1.0 0.05 5.0
  sleep 0.1
done
echo done all pdfs


cat PDF_POSCAR* > all_pdf.txt

cat>fileplot<<!
set xlabel "Distance (Angstrom)"
set ylabel "Freq"
set title '$NAME'
plot "all_pdf.txt" u 1:2 lt 8 ps 1 title "Zr-Zr", "" u 1:3 title "Zr-C", "" u 1:4 title "C-C"
!

gnuplot -persist fileplot
