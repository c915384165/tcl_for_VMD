
#进行frame的循环筛选一直存在的OWindex 
#换思路不需要这个两个数列对比情况，输出所有index人为选择
proc loop_framegetindex {sel frame0 frame1} {
	for {set i $frame0} {$i <= [expr $frame1-1]} {incr i 1} {
		set b [basic_getindex $sel [expr 1+$frame0]]
	    set a [basic_getindex $sel $frame0]
		for {set j 0} {$j <= [expr [llength $b]-1]} {incr j 1} {	   
		for {set i 0} {$i <= [expr [llength $a]-1] } {incr i 1} {
		set d [lindex $b $j]
	 set e [lindex $a $i]
         if {$e != $d}  continue
	 if {$e == $d} {
		 set c {}
	 set lists [lappend c $e] 
          puts $lists  
          } else {
          puts wrong}
}
}
}
}


#去掉列表中相同的元素
proc lremove_repeat_list {listVariable} {
	set var1 $listVariable
	set value [lindex $var1 0]
	while {$value!=""} {
		lappend var2 $value

		set i [lsearch -exact $var1 $value]

		while {$i!=-1} {
			set var1 [lreplace $var1 $i $i]
			set i [lsearch -exact $var1 $value]
		}

		set var1 $var1
		set value [lindex $var1 0]

	}
#set var1 [lsort $var2]
	set var1 $var2
}
#一帧内选择原子index序号
proc basic_getindex {sel frame} {
     set selOW [atomselect top $sel frame $frame]
     #set OWlist [lremove_repeat_list [$selOW get index]]
     set OWlist [lsort -unique [$selOW get index]]
     split $OWlist
}
proc num_basic_getindex {sel frame} {
     puts [llength [basic_getindex $sel $frame]]
}
#frame循环输出所有frame内的原子序号
proc allframe_index {sel frame0 frame1  output_name} {
     set out_file [open $output_name-msd.dat w]
     for {set j $frame0} {$j <= $frame1} {incr j 1} {
		puts $out_file  [basic_getindex $sel $j]	
	}
	close $out_file 
}

#从这里开始自己写的MSD 
# changed date:20150410-12:29 
# add input_name of lindex dat file
proc  calculate_MSD_new {frame0 frame1 framefrom frameto input_name outname} {
	set ffff [open $input_name r]
	set indexlist [read $ffff]
	puts "[llength $indexlist]"
	# if indexlist is empty then donothing if not  ,measure the msd
	if {[llength $indexlist]>0} {

		set nummsd 0
		package require sgsmooth 1.1
		# initialize msd array
		for {set i $frame0} {$i < $frame1} {incr i} {
			set msd($i) 0.0
		}
		# loop over residues 主程序
		foreach idx $indexlist {
			puts "processing index $idx"
			set poslist {}
			set sel [atomselect top "index $idx"]

			# fill poslist-此时储存所有index在选择时间的坐标
			for {set i $frame0} {$i < $frame1} {incr i} {
				$sel frame $i
				lappend poslist [measure center $sel]
			}
			# compute msd for the rest of the trajectory剩下的时间？
			set nf $frameto
			for {set i $framefrom} {$i < $nf} {incr i} {
				set ref [lindex $poslist 0]
				set poslist [lrange $poslist 1 end]
				$sel frame $i
				lappend poslist [measure center $sel]
				set j $frame0
				foreach pos $poslist {
					set msd($j) [expr $msd($j) + [veclength2 [vecsub $ref $pos]]]
					incr j
				}
				incr nummsd
			}
			$sel delete
		}

		set tval {}
		set msdval {}
	# normalize and build lists for output
		for {set i $frame0} {$i < $frame1} {incr i} {
			lappend tval  $i
			lappend msdval [expr $msd($i)/$nummsd]
		#lappend msdval [expr $msd($i)]
		}

	# compute numerical derivative
		set msdder [sgsderiv $msdval 2 4]

	# write out
		set fp [open $outname-$frame0-$frame1-$framefrom-$frameto-MSD.dat w]
		foreach t $tval m $msdval d $msdder {
			puts $fp "$t  $m  [expr {$d/6.0}]"
		}
	close $fp
	} else {
		set fp [open $outname-$frame0-$frame1-$framefrom-$frameto-MSD.dat w]
		puts $fp "no index"
		close $fp
	}

}

proc basic_get_number {sel frame get_what} {
     set selOW [atomselect top $sel frame $frame]
     set OWlist [lsort -unique -integer [$selOW get $get_what]]
     split $OWlist
}

proc basic_get_string {sel frame get_what} {
     set selOW [atomselect top $sel frame $frame]
     set OWlist [lsort -unique [$selOW get $get_what]]
     split $OWlist
}
#proc load_index_222 {input_name  var_name} {
#	set ffff [open $input_name r]
#	set var_name {}
#	while {[gets $ffff line] >=0} {
#			gets $ffff line
#			puts $line
#			for {set i 0} {$i < [llength $line]} {incr i} {
#				puts [lindex $line $i]
#				lappend var_name [lindex $line $i]
#			}
#	}
#	puts $var_name
#	close $ffff
#}
#
proc  calculate_MSD_new_selection {frame0 frame1 framefrom frameto atm_sel outname} {
    set residue_list [lsort -unique -integer [[atomselect top $atm_sel] get residue]]
	puts "[llength $residue_list]"
	# if residue_list is empty then donothing if not  ,measure the msd
	if {[llength $residue_list]>0} {

		set nummsd 0
		package require sgsmooth 1.1
		# initialize msd array
		for {set i $frame0} {$i < $frame1} {incr i} {
			set msd($i) 0.0
		}
		# loop over residues 主程序
		foreach idx $residue_list {
			puts "processing residue $idx"
			set poslist {}
			set sel [atomselect top "residue $idx"]

			# fill poslist-此时储存所有index在选择时间的坐标
			for {set i $frame0} {$i < $frame1} {incr i} {
				$sel frame $i
				lappend poslist [measure center $sel]
			}
			# compute msd for the rest of the trajectory剩下的时间？
			set nf $frameto
			for {set i $framefrom} {$i < $nf} {incr i} {
				set ref [lindex $poslist 0]
				set poslist [lrange $poslist 1 end]
				$sel frame $i
				lappend poslist [measure center $sel]
				set j $frame0
				foreach pos $poslist {
					set msd($j) [expr $msd($j) + [veclength2 [vecsub $ref $pos]]]
					incr j
				}
				incr nummsd
			}
			$sel delete
		}

		set tval {}
		set msdval {}
	# normalize and build lists for output
		for {set i $frame0} {$i < $frame1} {incr i} {
			lappend tval  $i
			lappend msdval [expr $msd($i)/$nummsd]
		#lappend msdval [expr $msd($i)]
		}

	# compute numerical derivative
		set msdder [sgsderiv $msdval 2 4]

	# write out
		set fp [open $outname-$frame0-$frame1-$framefrom-$frameto-MSD.dat w]
		foreach t $tval m $msdval d $msdder {
			puts $fp "$t  $m  [expr {$d/6.0}]"
		}
	close $fp
	} else {
		set fp [open $outname-$frame0-$frame1-$framefrom-$frameto-MSD.dat w]
		puts $fp "no index"
		close $fp
	}

}



























