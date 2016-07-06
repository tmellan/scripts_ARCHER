#!/bin/bash

DIR=/work/e89/e89/tamellan/scripts_ARCHER/

rm -r PDF_ANALYSIS_vasprun
mkdir PDF_ANALYSIS_vasprun

cp $DIR/poscar2pdf $DIR/extract_POSCARfromMD.py vasprun.xml PDF_ANALYSIS_vasprun

# cat the 'end' onto vasprun.xml automatically ie </modeling>


cd PDF_ANALYSIS_vasprun && echo "</modeling>" >> vasprun.xml && python extract_POSCARfromMD.py vasprun.xml &&

echo done python pymatgen splitting vasprun.xml
sleep 1
#var=`cat nionic_steps`

#make number of ionic steps and automatically detected variable

STEPS=`cat nion`
echo STEPS=$STEPS
for (( i=1; i<=$STEPS; i++)); do 
  ./poscar2pdf POSCAR$i 0.7 0.02 4.7 
  sleep 0.1
done
echo done all pdfs


NAME="Simulation 1) PDF ZrC 0.7-4.7Ang in 0.02 steps for DFT high parameter MD simulation $STEPS steps (3fs)"
cat PDF_POSCAR* > all_pdf.txt

cat>fileplot<<!
set xlabel "Distance (Angstrom)"
set ylabel "Freq"
set title '$NAME'
plot "all_pdf.txt" u 1:2 lt 8 ps 4 title "Zr-Zr", "" u 1:3 title "Zr-C", "" u 1:4 title "C-C"
!

gnuplot -persist fileplot
