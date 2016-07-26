#!/bin/bash

list="4.685Ang_760K 4.685Ang_1900K 4.685Ang_2500K 4.685Ang_3200K 4.685Ang_3805K"
for i in $list; do 
  cd $i
  cp ../SCRIPTS_MD_UP_sample/* .
  ./pdf_allvasprun.sh
  cd ../
  echo $i
done
echo done pdfs
