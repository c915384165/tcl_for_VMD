#date: 2015-0413
#writen by Ryan
#Chinese name :Tao Ren
#email:rorob@163.com
#qq:915384165
#this small tcl script program is used to measure the SCD of surfactants in water
#maybe someother thins you 
#in this paper "understanding the structure of ..." ACS lagmuir
#measure the two of resid cos^2*3-1/2
proc vector_cos {residuei residuej CAH_0 CAA_0  framexyz } {
	set sel1i [measure center [atomselect top "resid $residuei and name $CAH_0" frame $framexyz ]]
	set sel2i [measure center [atomselect top "resid $residuei and name $CAA_0" frame $framexyz ]]
	set sel1j [measure center [atomselect top "resid $residuej and name $CAH_0" frame $framexyz ]]
	set sel2j [measure center [atomselect top "resid $residuej and name $CAA_0" frame $framexyz ]]
    expr ([expr [vecdot  [vecsub $sel2i $sel1i] [vecsub $sel2j $sel1j]]/[veclength [vecsub $sel1i $sel2i]]/[veclength [vecsub $sel1j $sel2j]]]**2*3-1)/2
}
#measur the average value of the list
#only numbers can be read
proc average list {
    expr ([join $list +])/[llength $list]
}
#mesure the C22 of the  selections_list
proc vector_selection_head_tali_frame01 {atomsel_list CAH_0 CAA_0 frame_0} {
	set list_001 [[atomselect top $atomsel_list] get resid]
	set list_001_lsort [lsort -unique -integer $list_001] 
	set llength_list [llength $list_001_lsort]
	for {set i 0} {$i < $llength_list} {incr i} {
		if {[llength $list_001_lsort] >1} {
			set first_lindex [lindex $list_001_lsort 0]
			set list_001_lsort [lreplace $list_001_lsort 0 0]
			foreach list_xxx $list_001_lsort {
				lappend c22_list [vector_cos $first_lindex $list_xxx $CAH_0 $CAA_0 $frame_0]
			}
		} else {
		}
	}
	expr [average $c22_list]
}
# add frame loop
proc Scd_selection_CAH01_frame01_loop  {atomsel_list CAH_0 CAA_0 frame_0 frame_1} {
	for {set i $frame_0 } {$i <= $frame_1} {incr i 1} {
        lappend list_vector2  "[vector_selection_head_tali_frame01 $atomsel_list $CAH_0 $CAA_0 $i ]"
	}
	expr [average $list_vector2]
}
# used to write the dat output file 
proc 2015_scd {atomsel_list CAH_0 C1 C2 C3 C4 C5 C6 C7 frame_0 frame_1 output_name } {
	set outfile [open ijangleScd_$output_name\_$frame_0-$frame_1$CAH_0.dat w]
	puts $outfile "
		[Scd_selection_CAH01_frame01_loop $atomsel_list $CAH_0 $C7 $frame_0 $frame_1]
		[Scd_selection_CAH01_frame01_loop $atomsel_list $CAH_0 $C6 $frame_0 $frame_1]
		[Scd_selection_CAH01_frame01_loop $atomsel_list $CAH_0 $C5 $frame_0 $frame_1]
		[Scd_selection_CAH01_frame01_loop $atomsel_list $CAH_0 $C4 $frame_0 $frame_1]
		[Scd_selection_CAH01_frame01_loop $atomsel_list $CAH_0 $C3 $frame_0 $frame_1]
		[Scd_selection_CAH01_frame01_loop $atomsel_list $CAH_0 $C2 $frame_0 $frame_1]
		[Scd_selection_CAH01_frame01_loop $atomsel_list $CAH_0 $C1 $frame_0 $frame_1]
	"
		#[Scd_selection_CAH01_frame01_loop $atomsel_list $CAH_0 $C8 $frame_0 $frame_1]
	close $outfile
}

