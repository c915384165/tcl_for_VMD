proc resname_log {} {
	set resname_list [lsort -unique [[atomselect top all] get resname]]
	set outfile [open resname.log w]
	puts $outfile "[pwd]"	
	puts $outfile "resname:$resname_list"
	foreach resname_xx $resname_list {
		puts $outfile "$resname_xx:"
		puts $outfile "[llength [lsort -unique [[atomselect top "resname $resname_xx"] get residue]]]"
	}
	close $outfile
	vi resname.log
}
proc mdaaa {} {
	mol delete all
}
# proc residue_get_name_tcl { atomselect_getname } {
	# set index_list [lsort -unique [[atomselect top "$atomselect_getname"] get index]]
	# set outfile [open change_name.tcl w]
	# foreach index_xx $index_list {
		# set resname_xx [[atomselect top "index $index_xx"] get resname]
		# set name_xx [[atomselect top "index $index_xx"] get name]
		# puts $outfile "\[atomselect top \"resname $resname_xx name $name_xx\"\] set name $name_xx"
	# }
	# close $outfile
# }
proc residue_get_name_tcl { residue_getname } {
	set name_list [lsort [[atomselect top "residue $residue_getname"] get name]]
	set outfile [open residue_change_name-$residue_getname.tcl w]
	foreach name_xx $name_list {
		set resname_xx [lsort -unique [[atomselect top "residue $residue_getname"] get resname]]
		puts $outfile "\[atomselect top \"resname $resname_xx and name $name_xx\"\] set name $name_xx"
	}
	close $outfile
	vi residue_change_name-$residue_getname.tcl
}
proc change_residue_and_name { resname_select add_number name_00 name_11 } {
	set resid_list [lsort -unique [[atomselect top "resname $resname_select"] get residue]]
	echo " resids list: $resid_list"
	foreach resid_xx $resid_list {
		set new_resid [expr $resid_xx + $add_number]
		[atomselect top "residue $resid_xx and name $name_00"] set resid $new_resid 
		[atomselect top "resid $new_resid and name $name_00"] set name $name_11
		unset new_resid
	}
}
proc residue_get_name_tcl_2 { residue_getname } {
	set all_residue_numbers [ llength [ lsort -unique [ [ atomselect top all ] get residue ] ] ]
	set name_list [lsort [[atomselect top "residue $residue_getname"] get name]]
	set outfile [open residue_change_name-$residue_getname-2.tcl w]
	set resname_xx [lsort -unique [[atomselect top "residue $residue_getname"] get resname]]
	foreach name_xx $name_list {
		puts $outfile "change_residue_and_name $resname_xx $all_residue_numbers $name_xx $name_xx"
	}
	close $outfile
	vi residue_change_name-$residue_getname-2.tcl
}
proc change_resid {} {
	set residue_list_all [lsort -unique [[atomselect top all] get residue] ]
	foreach residue_xx $residue_list_all {
		[atomselect top "residue $residue_xx"] set resid [expr $residue_xx + 1]
	}
}