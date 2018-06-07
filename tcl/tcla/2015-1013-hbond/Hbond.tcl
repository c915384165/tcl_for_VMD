proc Hbond_ryan {frame_0 frame_1 atom_selc distance_0 angle_0} {
	# set outfile [open $output_name.dat w]
	for {set j $frame_0} {$j <= $frame_1} {incr j} {
		set bonds_list [measure hbonds $distance_0 $angle_0 [atomselect top water frame $j] [atomselect top "$atom_selc" frame $j]]
		set bonds_list_1 [lindex $bonds_list 0]
		# puts $bonds_list
		# puts $bonds_list_1
		set bonds_list_1_num [llength $bonds_list_1]
		
		# puts "$j $bonds_list_1_num"
		
		# puts $outfile "$j $bonds_list_1_num"
		lappend list_bonds_num $bonds_list_1_num
	}
	
	# puts $list_bonds_num
	
	expr [average $list_bonds_num]*1.0/[[atomselect top "$atom_selc"] num]
	# close $outfile
}
proc output_hbond {} {

	mol delete all
	play step-10.vmd
	
	set output_name [file tail [pwd]]
	file mkdir hbond-$output_name
	cd hbond-$output_name
	
	set outfile [open hbond_$output_name.dat w]
		source J:/tcl/tcla/2015-1012/msd_conf.tcl
		puts $outfile "$within 30 name $name"
		puts $outfile [Hbond_ryan 149 199 "name $name" $within 30]
	close $outfile
	vi hbond_$output_name.dat
	cd ..
}