proc msd_5_out_1 {} {
	
	# source ../msd_conf.tcl
	source J:/tcl/tcla/2015-1012/msd_conf.tcl
	
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

proc auto_analysis_msd {} {
# 0 outputname
	set output_name [file tail [pwd]]
	echo 0
# 1 mol delete all
	mol delete all
	echo 1
# 2 load vmd
	play step-1.vmd
	echo 2
# 3 source tcl
	# source J:/tcl/tclb-2015-0706.tcl
	echo 3.1
	# source msd_.tcl
	echo 3.2
# 4 run program? no mkdir 
	file mkdir msd-$output_name
	echo 4.1
	cd msd-$output_name
	echo 4.2
# 5 measure 
	# set end_frame 200
	msd_5_out_1
	# set outputname 
	echo 5.3
# 6 mol delete all
	mol delete all
	echo 6.1
	file copy J:/tcl/tcla/2015-1012/mmsd.m .
	cd ..
	echo 6.3
	echo "system $output_name msd done"
}