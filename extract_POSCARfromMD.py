# coding: utf-8
from pymatgen.io.vaspio import Vasprun
vr=Vasprun('vasprun.xml')
allposcar=vr.structures
dict={"POSCAR"}
for i, item in enumerate(allposcar):
    print("POSCAR"+str(i))
    item.to(filename="POSCAR"+str(i))
    print(item)
