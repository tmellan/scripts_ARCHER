from pymatgen.io.vaspio import Vasprun

vr=Vasprun("vasprun.xml")

structure0=vr.structures[0]
structure1=vr.structures[391]

from pymatgen.analysis.diffraction.xrd import XRDCalculator

c = XRDCalculator()

c.show_xrd_plot(structure0)
c.show_xrd_plot(structure1)
