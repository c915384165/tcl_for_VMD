#basic for asin angle, angle with xy plane
proc _zangle_asin {name_0 name_1 residue_xxx framexyz} {
    set sel0m [measure center [atomselect top "residue $residue_xxx and name $name_0" frame $framexyz]]
    set sel1m [measure center [atomselect top "residue $residue_xxx and name $name_1" frame $framexyz]]
    #set sel2m [measure center [atomselect top $sel2 frame $framexyz]]
    expr asin([expr [vecdot {0 0 1} [vecsub $sel1m $sel0m]]/[veclength [vecsub $sel0m $sel1m]]])*360/6.2831852
}
proc _zangle_acos {name_0 name_1 residue_xxx framexyz} {
    set sel0m [measure center [atomselect top "residue $residue_xxx and name $name_0" frame $framexyz]]
    set sel1m [measure center [atomselect top "residue $residue_xxx and name $name_1" frame $framexyz]]
    #set sel2m [measure center [atomselect top $sel2 frame $framexyz]]
    expr acos([expr [vecdot {0 0 1} [vecsub $sel1m $sel0m]]/[veclength [vecsub $sel0m $sel1m]]])*360/6.2831852
}

#asin frame loop

proc angle_ryan_0410_all  {atomsel_list output_name frame_0 frame_1 CAH_0 CAA_0 as_ac abs_zf} {
	set residue_list [lsort -unique -integer [[atomselect top $atomsel_list] get residue]]
	set outfile [open $output_name.dat w]
	foreach id_x $residue_list {
		for {set j $frame_0} {$j <= $frame_1} {incr j} {
			switch $as_ac {
				asin {puts $outfile "$id_x $j $as_ac [expr $abs_zf*[_zangle_asin $CAH_0 $CAA_0 $id_x $j]]"}
				acos {puts $outfile "$id_x $j $as_ac [expr $abs_zf*[_zangle_acos $CAH_0 $CAA_0 $id_x $j]]"}
			}
		}
	}
	close $outfile
}

proc angle_ryan_0410 {atomsel_list output_name frame_0 frame_1 CAH_0 CAA_0 as_ac abs_zf} {
	set residue_list [lsort -unique -integer [[atomselect top $atomsel_list] get residue]]
	set outfile [open zangles-$output_name.dat w]
	foreach id_x $residue_list {
		for {set j $frame_0} {$j <= $frame_1} {incr j} {
			switch $as_ac {
				asin {puts $outfile "[expr $abs_zf*[_zangle_asin $CAH_0 $CAA_0 $id_x $j]]"}
				acos {puts $outfile "[expr $abs_zf*[_zangle_acos $CAH_0 $CAA_0 $id_x $j]]"}
			}
		}
	}
	close $outfile
}

