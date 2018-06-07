source ./lzp_Massdensity.tcl
source ./Num_density.tcl
source ./ryan_scd_list_loop.tcl
source ./ryan_newangle.tcl
source ./segname.tcl
source ./rename.tcl
# mass-density
2015-mass-density -100 100 8F1S3O-water "resname SOL" 60 60 2 150 200 1
# num-density
num_density_0010 -100 100 8F1S3O-tail  "name CAA"    60 60 2 150 200 1
num_density_0010 -100 100 8F1S3O-head  "name SAI or resname PFN and name CAH"    60 60 2 150 200 1
num_density_0010 -100 100 8F1S3O-SOD  "resname SOD"    60 60 2 150 200 1
# scd
2015_scd "resname PFN PFS and z>0" CAH CAA CAB CAC CAD CAE CAF CAG 150 200 8F1S3O-scd-up
# zangles
angle_ryan_0410 "resname PFN PFS and z>0" 8F1S3O-up 150 200 CAH CAA acos 1 
# rdf
source RDF.tcl