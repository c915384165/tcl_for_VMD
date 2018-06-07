# 列表
# 排序
# set ai [lsort -integer $a]
# 去掉重复
# set au [lsort -unique $a]

# 删除元素
# set ar [lreplace $a 0 0]
# 切除
# set ac [lsearch -all -inline -not -exact -integer $a 2]

# 找相同元素
# puts [lsearch $a 2]

# 找相同元素
# puts [lsearch -all $a 2]

# puts [lsearch -all -inline $a 2]

# puts [lsearch -all -inline -exact -integer $a 2]

# puts $a

# puts $ai

# puts $au

# puts $ar
# 找相同元素 只限整数
proc find_reapt_times {list_all repeat_val} {
	llength [lsearch -all -inline -exact -integer $list_all  $repeat_val]
}
# find_reapt $a 3
# 查找相同元素中 次数大于等于选定值的变量 并输出结果o
# 如果界限设定过高会返回无变量出错！
proc list_max_integer {list_value} {
	expr max([join $list_value ,])
}
proc find_reapt_all {list_all value_0} {
	set sorted_list [lsort -integer $list_all]
	set key_sorted_list [lsort -unique -integer $list_all]
	foreach key_0 $key_sorted_list {
		set longth($key_0) [find_reapt_times $list_all $key_0]
		puts "$key_0 $longth($key_0)"
		lappend longth_list $longth($key_0)
	}
	set max_times [list_max_integer $longth_list]
	if {$value_0<=$max_times} {
		foreach key_0 $key_sorted_list {
			if {$longth($key_0)>=$value_0} {
				lappend selected_list $key_0
			}
		}
		split $selected_list
	} else {
		puts "value_0 is too large"
	}
}
# set a [list 50 1 2 3 1 2 3 4 3 2 1 2]
# find_reapt_all $a 2
# 选择 去掉重复的元素

# 选择范围内的原子index 输出文件
proc allframe_index { ratio_of_within ratio_for_select name_allframe frame0 frame1 } {
	set sel "name OW and within $ratio_of_within of name $name_allframe and x<25 and x>-25 and y<25 and y>-25"
	for {set j $frame0} {$j <= $frame1} {incr j 1} {
		# frame $j
		set frameindex($j) [lsort -integer [[atomselect top "$sel" frame $j] get index]] 
		# for set 
		puts "pcessing frame $j"
		# puts $frameindex($j)
		foreach index_000 $frameindex($j) {
			lappend list_all_to_select $index_000
		}
	}
	# puts [lsort $list_all_to_select]
	# echo $max_times
	find_reapt_all $list_all_to_select $ratio_for_select
	# puts "ratio is [expr $ratio_for_select*1.0/($frame1-$frame0)]"
}

proc  calculate_MSD_new {ratio_of_within ratio_for_select name_allframe frame0 frame1 framefrom frameto outname } {
	set indexlist [allframe_index $ratio_of_within $ratio_for_select $name_allframe $frame0 $frameto]
	# set [read $ffff]
	puts $indexlist
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
		set fp [open $outname.dat w]
		# puts $fp "$ratio_of_within $ratio_for_select $resname_allframe $name_allframe $frame0 $frame1 $framefrom $frameto $outname"
		foreach t $tval m $msdval d $msdder {
			puts $fp "[expr $t-$frame0]  $m  [expr {$d/6.0}]"
		}
	close $fp
	} else {
		set fp [open $outname.dat w]
		puts $fp "no index"
		close $fp
	}

}
# allframe_index 4 0.1 DRG "OAB OAC" 150 200

proc msd_5_out_1 {within framesel name outputname frame_0 } {
	
	calculate_MSD_new $within $framesel $name [expr $frame_0+0  ] [expr $frame_0+50  ] [expr $frame_0+50  ] [expr $frame_0+100 ] $outputname-1
	calculate_MSD_new $within $framesel $name [expr $frame_0+50 ] [expr $frame_0+100 ] [expr $frame_0+100 ] [expr $frame_0+150 ] $outputname-2
	calculate_MSD_new $within $framesel $name [expr $frame_0+100] [expr $frame_0+150 ] [expr $frame_0+150 ] [expr $frame_0+200 ] $outputname-3
	calculate_MSD_new $within $framesel $name [expr $frame_0+150] [expr $frame_0+200 ] [expr $frame_0+200 ] [expr $frame_0+250 ] $outputname-4
	calculate_MSD_new $within $framesel $name [expr $frame_0+200] [expr $frame_0+250 ] [expr $frame_0+250 ] [expr $frame_0+300 ] $outputname-5
	calculate_MSD_new $within $framesel $name [expr $frame_0+250] [expr $frame_0+300 ] [expr $frame_0+300 ] [expr $frame_0+350 ] $outputname-6
	calculate_MSD_new $within $framesel $name [expr $frame_0+300] [expr $frame_0+350 ] [expr $frame_0+350 ] [expr $frame_0+400 ] $outputname-7
	calculate_MSD_new $within $framesel $name [expr $frame_0+350] [expr $frame_0+400 ] [expr $frame_0+400 ] [expr $frame_0+450 ] $outputname-8
	calculate_MSD_new $within $framesel $name [expr $frame_0+400] [expr $frame_0+450 ] [expr $frame_0+450 ] [expr $frame_0+500 ] $outputname-9

}
proc update_msd {} {
	source J:/tcl/tcl-test/test-1010.tcl
}
