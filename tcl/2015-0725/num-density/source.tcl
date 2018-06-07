source ./Num_density.tcl
num_density_0010 -100 100 7F1C2O-8F1S3O-CAA "name CAA"    60 60 2 150 200 1
[atomselect top "resname PFN and name CAH"] set name SAI
num_density_0010 -100 100 7F1C2O-8F1S3O-CAH-SAI "name SAI"    60 60 2 150 200 1
num_density_0010 -100 100 7F1C2O-8F1S3O-SOD "resname SOD"    60 60 2 150 200 1
