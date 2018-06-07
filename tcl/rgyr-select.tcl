proc 0912-rgyr_ryan { atomsel_list name_list frame_0 frame_1 output_name } {
	#echo "set residue_list"
	set residue_list [lsort -unique -integer [[atomselect top $atomsel_list] get residue]]
	echo $residue_list
	#echo "set outfile"
	set outfile [open $output_name.dat w]
	#echo $outfile
	#echo "foreach"
	foreach id_x $residue_list {
		#echo $id_x
		for {set j $frame_0} {$j <= $frame_1} {incr j} {
			#echo $j
			puts $outfile "[measure rgyr [atomselect top "name $name_list and residue $id_x" frame $j]]"
			}
	}
	close $outfile
}