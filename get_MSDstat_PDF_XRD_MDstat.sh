#!/bin/bash

dir="/work/e89/e89/tamellan/MD/MD_low/Cvac_500_222kp/6hrRun/C_and_Zr_rearranged/scripts"

#Post processing commands

#Get the MSD, MSD mean and MSD error plots
cp $dir/poscar2* $dir/msd.py $dir/msd_error.awk .
python poscar2xyz.py && python msd.py && ./msd_error.awk

#Get the PDFs
module load anaconda/python3
cp $dir/pdf_allvasprun.sh $dir/extract_POSCARfromMD.py .
./pdf_allvasprun.sh

#XRD
#mkdir XRD ; cp PDF_ANALYSIS_vasprun/vasprun.xml XRD/. ; cd XRD/ ; cp ../POTCAR .  ;  cp $dir/XRD_pymatgen.py . 
#module load anaconda/python3
#python XRD_pymatgen.py

#MD sd and mean
cp $dir/MD_error.sh . 
./MD_error.sh
