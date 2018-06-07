source ryan_scd_list_loop.tcl
proc change_resid {} {
	set residue_list_all [lsort -unique [[atomselect top all] get residue] ]
	foreach residue_xx $residue_list_all {
		[atomselect top "residue $residue_xx"] set resid [expr $residue_xx + 1]
	}
}
change_resid
2015_scd "resname GE01 and z>0" CBY CBW CCA CCE CCI CCK CCG CCC 1500 2000 8f2eo-pfos-11w-scd-15002000-up
#2015_scd "resname FOA DRG and z>0" CAH CAA CAB CAC CAD CAE CAF CAG 1500 2000 8h8f2eo-11w-scd-up

