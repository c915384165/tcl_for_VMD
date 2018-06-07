proc 0912-rgyr_ryan { atomsel_list name_list frame_0 frame_1 output_name } {
	#echo "set residue_list"
	set residue_list [lsort -unique -integer [[atomselect top $atomsel_list] get residue]]
	set outfile [open $output_name w]
	foreach id_x $residue_list {
		for {set j $frame_0} {$j <= $frame_1} {incr j} {
			puts $outfile "[measure rgyr [atomselect top "residue $id_x and name $name_list" frame $j]]"
			}
	}
	close $outfile
}