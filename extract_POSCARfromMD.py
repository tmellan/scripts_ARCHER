# coding: utf-8
from pymatgen.io.vaspio import Vasprun
from pymatgen.analysis.diffusion_analyzer import DiffusionAnalyzer
vr=Vasprun('vasprun.xml')

#obj=vr.structures[5]
#obj.to(filename="POSCAR.test.5")
#
#POSCAR=dict()
#for i in range(0, 3):
#    obj=vr.structures[i]
#    obj.to(filename="POSCAR.i")

allposcar=vr.structures
#print(allposcar)

#POSCAR=dict()
#for i in allposcar:
#     print(i)
#     i.to(filename="POSCAR'i'")

dict={"POSCAR"}
for i, item in enumerate(allposcar):
    print("POSCAR"+str(i))
    item.to(filename="POSCAR"+str(i))
#    item.to(filename=dict))
#    allposcar[i].to(filename="POSCAR'i'")
    print(item)

#     poscar.to(filename="POSCAR'i'")

#for i in vr.structures
#    print(i)

#for i range(0,3:
#    obj=vr.structure[$i]
#    obj.to(filename="POSCAR.$i")

#obj=print(vr.structures[0])
#obj=vr.structures[0]
#obj.to(filename="test.poscar")
#obj.to(filename="test.cif")
#obj.to(filename="POSCAR.1")
#obj2=vr.structures[2]
#obj2.to(filename="POSCAR.2")
#obj10=vr.structures[10]
#obj10.to(filename="POSCAR.10")

#for i in range(0,3): 
#    obname="obj"i
#    posname="POSCAR"i
#    obname=vr.structures[i]
#    obname.to(filename="posname")
#
#for i (0..3); do
#  obj=vr.structure[$i]
#  obj.to(filename="POSCAR.$i")

  
