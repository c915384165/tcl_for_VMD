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