# only for surfactant  density
#frame loop
proc num_density_0009 {select nx ny thickness f1 f2 ratio} {
	set ntotal 0
	for {set i $f1} {$i <= $f2} {incr i 1} {
		set sel [atomselect top $select frame $i]
		incr ntotal [$sel num]
		$sel delete
	}
	expr $ntotal/[expr ($f2-$f1)+1]*10000/($nx*$ny*$thickness*$ratio*6.02)

}
#all surfctant density
proc num_density_0010 {range0 range1 output_name selections nx ny thickness frame1 frame2 ratio} {
    set outfile [open num-density-$output_name.dat w]
    #puts $outfile "\# path:[pwd]\n\# range:$range0-$range1 $nx*$ny*$thickness*$ratio frame:$frame1-$frame2 atomselect top \"$selections\" " 
    for {set j $range0} {$j <= $range1} {incr j} {
		puts $outfile "[expr 1*$j] [num_density_0009 "z>$j-[expr $thickness/2] and z<$j+[expr $thickness/2] and $selections" $nx $ny $thickness $frame1 $frame2 $ratio]"
    }
    close $outfile
}
