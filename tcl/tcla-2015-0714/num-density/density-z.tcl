set outfile [open density_OYC.dat w]
proc frn {select f1 f2} {
	set ntotal 0
	for {set i $f1} {$i <= $f2} {incr i 1} {
		set sel [atomselect top $select frame $i]
		incr ntotal [$sel num]
	$sel delete
	}
expr $ntotal/[expr ($f2-$f1)+1]
}
for {set j -50} {$j <= 50} {incr j 2} {
puts $outfile "[expr 1*$j]; [frn "z>$j-1 and z<$j+1 and type OYC" 90 249]"
}
close $outfile
set outfile [open density_FC.dat w]
proc frn {select f1 f2} {
	set ntotal 0
	for {set i $f1} {$i <= $f2} {incr i 1} {
		set sel [atomselect top $select frame $i]
		incr ntotal [$sel num]
	$sel delete
	}
expr $ntotal/[expr ($f2-$f1)+1]
}
for {set j -50} {$j <= 50} {incr j 2} {
puts $outfile "[expr 1*$j]; [frn "z>$j-1 and z<$j+1 and type FC2 FC3" 90 249]"
}
close $outfile
