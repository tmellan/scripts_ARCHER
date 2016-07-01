#!/bin/bash
module unload anaconda-compute/python3
module load anaconda-compute/python2
sed '6d' CONTCAR > POSCAR

#python bond_length_calc_24.py POSCAR > 24out.bond_length_info
#python bond_length_calc_12.py POSCAR > 12out.bond_length_info
python bond_length_calc_6.py POSCAR > 6out.bond_length_info
awk 'NR >= 1 && NR <= 35' out.bond_length_info > bond_table
awk 'NR >= 37 && NR <= 137' out.bond_length_info > bond_gaussian
awk 'NR >= 138 && NR <= 162' out.bond_length_info > bond_histo
