proc cos_vecAB_vecCD {sel_a sel_b sel_c sel_d frame_number} {
	# sela "residue xx and name **"
	# measure center of 4 point
	set center_sel_a [measure center [atomselect top $sel_a frame $frame_number]]
	set center_sel_b [measure center [atomselect top $sel_b frame $frame_number]]
	set center_sel_c [measure center [atomselect top $sel_c frame $frame_number]]
	set center_sel_d [measure center [atomselect top $sel_d frame $frame_number]]
	# measure vector AB CD
	set vector_AB [vecsub $center_sel_b $center_sel_a]
	set vector_CD [vecsub $center_sel_d $center_sel_c]
	# vecdot AB*CD
	set vec_ABCD [vecdot $vector_AB $vector_CD]
	# length of AB CD
	set length_AB [veclength $vector_AB]
	set length_CD [veclength $vector_CD]
	# measure cos
	set cos_ABCD [expr $vec_ABCD/($length_AB*$length_CD)]
	# measure acos
	expr acos($cos_ABCD)*360/6.2831852
}

proc 0613-angle_ryan-test  { atomsel_list name_a name_b name_c name_d frame_0 frame_1 output_name } {
	echo "set residue_list"
	set residue_list [lsort -unique -integer [[atomselect top $atomsel_list] get residue]]
	echo $residue_list
	echo "set outfile"
	set outfile [open $output_name.dat w]
	echo $outfile
	echo "foreach"
	foreach id_x $residue_list {
		echo $id_x
		for {set j $frame_0} {$j <= $frame_1} {incr j} {
			echo $j
			puts $outfile "$id_x $j [cos_vecAB_vecCD "residue $id_x and name $name_a" "residue $id_x and name $name_b" "residue $id_x and name $name_c" "residue $id_x and name $name_d" $j]"
			}
	}
	close $outfile
}

proc 0613-angle_ryan { atomsel_list name_a name_b name_c name_d frame_0 frame_1 output_name } {
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
			puts $outfile "[cos_vecAB_vecCD "residue $id_x and name $name_a" "residue $id_x and name $name_b" "residue $id_x and name $name_c" "residue $id_x and name $name_d" $j]"
			}
	}
	close $outfile
}

