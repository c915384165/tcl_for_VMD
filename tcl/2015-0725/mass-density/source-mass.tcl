#2015-mass-density -100 100 resname_SOL "resname SOL" 60 60 2 1500 2000 1
source ./lzp_Massdensity.tcl
# proc auto_mass-density-resname { out_file_name } {
	# set resname_list [lsort -unique [[atomselect top all] get resname]]
	# foreach resname_inlist $resname_list {
		# 2015-mass-density -100 100 $out_file_name-$resname_inlist "resname $resname_inlist"     60 60 2 150 200 1
		# j.j2015-mass-density -100 100 8F1S3O-PFS  "resname PFS"     60 60 2 150 200 1
		# 2015-mass-density -100 100 8F1S3O-PFSN "resname PFS PFN" 60 60 2 150 200 1
		# 2015-mass-density -100 100 8F1S3O-SOL "resname SOL" 60 60 2 150 200 1
		# 2015-mass-density -100 100 8F1S3O-SOD "resname SOD" 60 60 2 150 200 1
		# }
# }
auto_mass-density-resname SDS	
# 2015-mass-density -100 100 7F1C2O-8F1S3O-PFSPFN "resname PFS PFN" 60 60 2 150 200 1
