#basic vector with Z axi
proc zangle_cos {sel1 sel2 framexyz} {
    set sel1m [measure center [atomselect top $sel1 frame $framexyz]]
    set sel2m [measure center [atomselect top $sel2 frame $framexyz]]
    expr ([expr [vecdot {0 0 1} [vecsub $sel2m $sel1m]]/[veclength [vecsub $sel1m $sel2m]]]**2*3-1)/2
}

#average
proc average list {
    expr ([join $list +])/[llength $list]
}
proc sum_list list {
    expr ([join $list +])
}
#one frame residue loop
proc proc_3cos2-1_frame_residue01 {frame_0 residue_0 residue_1 CAH_0 CAA_0} {
	for {set j $residue_0} {$j <= $residue_1} {incr j} {
	lappend list_1 "[zangle_cos "residue $j and name $CAH_0" "residue $j and name $CAA_0" $frame_0]"
    }
    expr [average $list_1]
} 

#order P Scd frame loop
proc Scd_frame01_resiude01_outname { frame0 frame1 residue_0 residue_1 CAH_0 CAA_0} {
	for {set i $frame0 } {$i <= $frame1} { incr i 1 } {
        lappend list_2  "[proc_3cos2-1_frame_residue01 $i $residue_0 $residue_1 $CAH_0 $CAA_0 ]"
}
expr [average $list_2]

}

#pichuli Scd
proc  pclScd_frame01_residue01_CAH01_outname { frame_0 frame_1 residue_0 residue_1 CAH_0 C1 C2 C3 C4 C5 C6 C7 C8 output_name } {
   set outfile [open  Scd_$output_name\_$frame_0-$frame_1$CAH_0.dat w]
   puts $outfile "[Scd_frame01_resiude01_outname $frame_0 $frame_1 $residue_0 $residue_1 $CAH_0 $C8]
[Scd_frame01_resiude01_outname $frame_0 $frame_1 $residue_0 $residue_1 $CAH_0 $C7]
[Scd_frame01_resiude01_outname $frame_0 $frame_1 $residue_0 $residue_1 $CAH_0 $C6]
[Scd_frame01_resiude01_outname $frame_0 $frame_1 $residue_0 $residue_1 $CAH_0 $C5]
[Scd_frame01_resiude01_outname $frame_0 $frame_1 $residue_0 $residue_1 $CAH_0 $C4]
[Scd_frame01_resiude01_outname $frame_0 $frame_1 $residue_0 $residue_1 $CAH_0 $C3]
[Scd_frame01_resiude01_outname $frame_0 $frame_1 $residue_0 $residue_1 $CAH_0 $C2]
[Scd_frame01_resiude01_outname $frame_0 $frame_1 $residue_0 $residue_1 $CAH_0 $C1]"
   close $outfile   
}


#basic vector with residuei and j  head to tail
proc vector_cos {residuei residuej CAH_0 CAA_0  framexyz } {
	set sel1i [measure center [atomselect top "residue $residuei and name $CAH_0" frame $framexyz ]]
	set sel2i [measure center [atomselect top "residue $residuei and name $CAA_0" frame $framexyz ]]
	set sel1j [measure center [atomselect top "residue $residuej and name $CAH_0" frame $framexyz ]]
	set sel2j [measure center [atomselect top "residue $residuej and name $CAA_0" frame $framexyz ]]
    expr ([expr [vecdot  [vecsub $sel2i $sel1i] [vecsub $sel2j $sel1j]]/[veclength [vecsub $sel1i $sel2i]]/[veclength [vecsub $sel1j $sel2j]]]**2*3-1)/2
}

#one frame (cos**2*3-1)/2 all residuei and j head to tail residueloop average
proc vector_residueij_CAH01_frame { residuei residuej CAH_0 CAA_0 frame_0} {
	for {set a $residuei} {$a < $residuej} {incr a 1} {
	         for {set b [expr 1+$a]} {$b < $residuej} {incr b 1} {
		lappend list_vector "[vector_cos  $a $b $CAH_0 $CAA_0 $frame_0 ]"}
    }
    expr [average $list_vector]
} 
#frame loop
proc vectorScd_residueij_CAH01_frame01  { residuei residuej CAH_0 CAA_0 frame_0 frame_1 } {
      for {set i $frame_0 } {$i <= $frame_1} { incr i 1 } {
        lappend list_vector2  "[vector_residueij_CAH01_frame  $residuei $residuej $CAH_0 $CAA_0 $i ]"
}
        expr [average $list_vector2]
}
#pichuli Scd ijangle
proc pclvector_Scd_residue01_CAH01_frame01_outname { residuei residuej CAH_0 C1 C2 C3 C4 C5 C6 C7 C8 frame_0 frame_1 output_name } {
    set outfile [open  ijangleScd_$output_name\_$frame_0-$frame_1$CAH_0.dat w]
    puts $outfile "[vectorScd_residueij_CAH01_frame01 $residuei $residuej $CAH_0 $C8 $frame_0 $frame_1]
[vectorScd_residueij_CAH01_frame01 $residuei $residuej $CAH_0 $C7 $frame_0 $frame_1]
[vectorScd_residueij_CAH01_frame01 $residuei $residuej $CAH_0 $C6 $frame_0 $frame_1]
[vectorScd_residueij_CAH01_frame01 $residuei $residuej $CAH_0 $C5 $frame_0 $frame_1]
[vectorScd_residueij_CAH01_frame01 $residuei $residuej $CAH_0 $C4 $frame_0 $frame_1]
[vectorScd_residueij_CAH01_frame01 $residuei $residuej $CAH_0 $C3 $frame_0 $frame_1]
[vectorScd_residueij_CAH01_frame01 $residuei $residuej $CAH_0 $C2 $frame_0 $frame_1]
[vectorScd_residueij_CAH01_frame01 $residuei $residuej $CAH_0 $C1 $frame_0 $frame_1]"
 close $outfile
}

#error bar
proc errorbarvectorScd_residueij_CAH01_frame01_outname  { residuei residuej CAH_0 CAA_0 frame_0 frame_1 outputname } {
	set outfile [open  errorijangleScd_$outputname\_$frame_0-$frame_1$CAH_0-$CAA_0.dat w]
      for {set i $frame_0 } {$i <= $frame_1} { incr i 1 } {
        lappend list_vector2  "[vector_residueij_CAH01_frame  $residuei $residuej $CAH_0 $CAA_0 $i ]"
}
   puts  $outfile   "$list_vector2"
 
   close $outfile
}
#pcl erro bar
proc pclerrorbar_residueij_CAH01_frame01_outname { residuei residuej CAH_0 C1 C2 C3 C4 C5 C6 C7 C8 frame_0 frame_1 outputname } {
       "	[errorbarvectorScd_residueij_CAH01_frame01_outname $residuei $residuej $CAH_0 $C1 $frame_0 $frame_1 $outputname ]
	[errorbarvectorScd_residueij_CAH01_frame01_outname $residuei $residuej $CAH_0 $C2 $frame_0 $frame_1 $outputname ]
	[errorbarvectorScd_residueij_CAH01_frame01_outname $residuei $residuej $CAH_0 $C3 $frame_0 $frame_1 $outputname ]
	[errorbarvectorScd_residueij_CAH01_frame01_outname $residuei $residuej $CAH_0 $C4 $frame_0 $frame_1 $outputname ]
	[errorbarvectorScd_residueij_CAH01_frame01_outname $residuei $residuej $CAH_0 $C5 $frame_0 $frame_1 $outputname ]
	[errorbarvectorScd_residueij_CAH01_frame01_outname $residuei $residuej $CAH_0 $C6 $frame_0 $frame_1 $outputname ]
	[errorbarvectorScd_residueij_CAH01_frame01_outname $residuei $residuej $CAH_0 $C7 $frame_0 $frame_1 $outputname ]
	[errorbarvectorScd_residueij_CAH01_frame01_outname $residuei $residuej $CAH_0 $C8 $frame_0 $frame_1 $outputname ]"

}
