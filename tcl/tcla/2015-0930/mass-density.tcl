#basic density
proc _density_snntf_proc {select nx ny thickness frame} {
	set atom_sel [atomselect top $select frame $frame]
	set sumweight_total [expr [measure sumweights $atom_sel weight mass]]
	expr $sumweight_total*10000/($nx*$ny*$thickness*6.02)
}
# selections "resname MOL"
proc proc_density_r0r1_outname_sel_nxy_thick_frame {range0 range1 output_name selections nx ny thickness frame} {
    set outfile [open proc_density_$output_name\_$frame.dat w]
    puts $outfile "\# path:[pwd]\n\# range:$range0-$range1 $nx*$ny $thickness frame:$frame atomselect top \"$selections\" " 
    for {set j $range0} {$j <= $range1} {incr j} {
	puts $outfile "[expr 1*$j]; [_density_snntf_proc "z>$j-[expr $thickness/2] and z<$j+[expr $thickness/2] and $selections" $nx $ny $thickness $frame]"
    }
    # for {set j [expr $range0+1]} {$j <= [expr $range1+1]} {incr j $thickness} {
    # 	puts $outfile "[expr 1*$j]; [density_snntf_proc "z>$j-[expr $thickness/2] and z<$j+[expr $thickness/2] and $selections" $nx $ny $thickness $frame]"
    # }
close $outfile
}
proc _density_snntf_average_proc {select nx ny thickness f1 f2} {
	set ntotal 0
	for {set i $f1} {$i <= $f2} {incr i 1} {
		set sel [atomselect top $select frame $i]
		set ntotal [expr [measure sumweights $sel weight mass]+$ntotal]
	$sel delete
	}
expr $ntotal/[expr ($f2-$f1)+1]*10000/($nx*$ny*$thickness*6.02)
}
proc proc_averagedensity_r0r1_outname_sel_nxy_thick_frame12 {range0 range1 output_name selections nx ny thickness frame1 frame2} {
    set outfile [open proc_av_density_$output_name\_$frame1_$frame2.dat w]
    puts $outfile "\# path:[pwd]\n\# range:$range0-$range1 $nx*$ny*$thickness frame:$frame1-$frame2 atomselect top \"$selections\" " 
    for {set j $range0} {$j <= $range1} {incr j} {
	puts $outfile "[expr 1*$j]; [_density_snntf_average_proc "z>$j-[expr $thickness/2] and z<$j+[expr $thickness/2] and $selections" $nx $ny $thickness $frame1 $frame2]"
    }
    # for {set j [expr $range0+1]} {$j <= [expr $range1+1]} {incr j $thickness} {
    # 	puts $outfile "[expr 1*$j]; [density_snntf_proc "z>$j-[expr $thickness/2] and z<$j+[expr $thickness/2] and $selections" $nx $ny $thickness $frame]"
    # }
close $outfile
}

###### only for surfactant  density
#frame loop
proc surfactant_density_snntf_average_ratio {select nx ny thickness f1 f2 ratio} {
	set ntotal 0
	for {set i $f1} {$i <= $f2} {incr i 1} {
		set sel [atomselect top $select frame $i]
		set ntotal [expr [measure sumweights $sel weight mass]+$ntotal]
	$sel delete
	}
expr $ntotal/[expr ($f2-$f1)+1]*10000/($nx*$ny*$thickness*$ratio*6.02)

}
#all surfctant density
proc 2015-mass-density {range0 range1 output_name selections nx ny thickness frame1 frame2 ratio} {
    set outfile [open mass-density-$output_name.dat w]
    #puts $outfile "\# path:[pwd]\n\# range:$range0-$range1 $nx*$ny*$thickness*$ratio frame:$frame1-$frame2 atomselect top \"$selections\" " 
    for {set j $range0} {$j <= $range1} {incr j} {
	puts $outfile "[expr 1*$j]  [surfactant_density_snntf_average_ratio "z>$j-[expr $thickness/2] and z<$j+[expr $thickness/2] and $selections" $nx $ny $thickness $frame1 $frame2 $ratio]"
    }
    close $outfile
}
proc auto_mass-density-resname { out_file_name } {
	set resname_list [lsort -unique [[atomselect top all] get resname]]
	foreach resname_inlist $resname_list {
		2015-mass-density -100 100 $out_file_name-$resname_inlist "resname $resname_inlist"     60 60 2 150 200 1
		#j.j2015-mass-density -100 100 8F1S3O-PFS  "resname PFS"     60 60 2 150 200 1
		# 2015-mass-density -100 100 8F1S3O-PFSN "resname PFS PFN" 60 60 2 150 200 1
		# 2015-mass-density -100 100 8F1S3O-SOL "resname SOL" 60 60 2 150 200 1
		# 2015-mass-density -100 100 8F1S3O-SOD "resname SOD" 60 60 2 150 200 1
		}
}