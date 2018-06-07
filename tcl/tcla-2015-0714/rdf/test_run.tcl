proc Run { } {
	global rdf
	global rdfdata
	#sets is the number of frames calculated so far, is used to calculate
	#average value 
	set sets 0
	global M_PI
	set startnum [$rdf.top.start.frame get]
	set endnum [$rdf.top.end.frame get]
	set cutoff [expr double ([$rdf.data.cutoff.num get])]
	set mbin [$rdf.data.mbin.num get ]
	set skipnum [$rdf.top.skip.frame get]
    if { $skipnum <= 0 } {
		puts "Skip should larger than 0 "
        return
	}
	global framenum
	set dr [expr $cutoff /  $mbin ]
	global rdffunc
	global box_x
	global box_y
	global box_z
	set box_x [expr double ([$rdf.boundary.x.num get])]
	set box_y [expr double ([$rdf.boundary.y.num get])]
	set box_z [expr double ([$rdf.boundary.z.num get])]



	#build atom selection keywords for Fromatom
	set fromstring " "
	foreach key { segname resname name } {
		set frominfo [$rdf.atominfo.from.$key.key get ]
		if { $frominfo != "*" } {
			append fromstring "$key $frominfo "
			if { $key != "name" } { 
     			append fromstring " and "
			}	
		}	
	}


	#build atom selection keywords for Toatom 
	set tostring " "
	foreach key { segname resname name } {
		set toinfo [$rdf.atominfo.to.$key.key get ]
		if { $toinfo != "*" } {
        	append tostring "$key $toinfo "
  			if { $key != "name" } { 
     			append tostring " and "
        	}
    	}
	}

	#build selectionlist
	set fromatomlist [atomselect top "$fromstring"]
	set toatomlist [atomselect top "$tostring" ]
	#calculate the density of to_atoms
	set volume [expr $box_x * [expr $box_y * $box_z]]
	set density [expr [expr [$toatomlist num]/$volume ]*[$fromatomlist num]]
	puts "Density $density"
	
	# If the number of frame is wrong?
	# else initialize the store space for rdfdata, and calculate
	if { [expr { $startnum > $framenum}] ||[expr {$endnum >=$framenum }] || [expr { $startnum > $endnum}] } {
		puts "Wrong frame number "
	} else { 
	for { set i 0 } { $i < $mbin } { incr i 1 } {
		set rdfdata($i) 0}

		for { set i $startnum } { $i <= $endnum } { incr i $skipnum } {

			# Call frame_RDF to calculate the numbers
			# First get the information of selections of each frame
			puts "Now processing Frame number $i, please be patient "
			set t1 [clock seconds]
			#rapidwrap $box_x $box_y $box_z $i
			$fromatomlist frame $i
			$toatomlist frame $i
			frame_RDF $fromatomlist $toatomlist $cutoff $dr
			set t2 [clock seconds]
			puts "This frame cost [expr $t2 - $t1] seconds"
			incr sets 1
		}

		# calculate the constant value for volume calculation
		# deltaV = 4/3*M_PI*$dr*$dr*$dr +4*M_PI*$dr*r1*r2
		set const1 [expr [expr 1.3333333* $M_PI] * [expr pow( $dr, 3)]] 
		set const2 [expr [expr 4 * $M_PI] * $dr]
		puts "dr $dr  const1 $const1  const2 $const2"

		#processing of data, RDF calculation
		puts "RDF function value"
		for { set i 0 } { $i < $mbin } { incr i 1 } {
   			set r1 [expr $dr*$i]
   			set r2 [expr $r1+$dr]
   			set deltaV [expr $const1+[expr $const2*[expr $r1*$r2]]]
   			set rdffunc($i) [expr [expr $rdfdata($i)/$density]/[expr  $deltaV * $sets]]
   			puts "[expr $i*$dr]     $rdffunc($i)"
		}

		# Draw on VMD display
		draw color red
		draw line {0 0 0 } {20 0 0 }
		draw line {0 0 0 } { 0 20 0 }
		draw line {0 0 0 } { 0 0 20 }
		draw color white
		for { set j 2 } { $j < $mbin } { incr j 1 } {
			set first "[expr [expr $j-1]*$dr]  $rdffunc([expr $j-1]) 0 "
  			set second "[expr $j*$dr]  $rdffunc($j) 0"
  			draw line $first $second
		}
	}
}