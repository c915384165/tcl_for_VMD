proc trxyz {x d} {
	set abc [atomselect top all]
	set cent [measure center $abc]
	$abc move [trans center "$cent" $x $d]
	#measure minmax $abc 
	#measure minmax $abc 
	#mmx_z_up all
}

proc trxyz_2 {select_type x d} {
	set abc [atomselect top $select_type]
	set cent [measure center $abc]
	$abc move [trans center "$cent" $x $d]
	measure minmax $abc 
}
proc trxyz_get_angle_z {x d CA0 CA1} {
    set abc [atomselect top all]
    set cent [measure center $abc]
    $abc move [trans center "$cent" $x $d]
    set sel0m [measure center [atomselect top "name $CA0" ]]
    set sel1m [measure center [atomselect top "name $CA1" ]]
    expr acos([expr [vecdot {0 0 1} [vecsub $sel1m $sel0m]]/[veclength [vecsub $sel0m $sel1m]]])*360/6.2831852
}
proc mxyz {c d} {
	set abc [atomselect top all]
	switch $c {x {$abc moveby "$d 0 0"} y {$abc moveby "0 $d 0"} z {$abc moveby "0 0 $d"}}
	measure center $abc
	mmx
	puts 	"up: [mmx_z_up all]"
	puts 	"down: [mmx_z_down all]"
}
proc resid_mxyz {residue_value c d} {
	set abc [atomselect top "residue residue_value"]
	switch $c {x {$abc moveby "$d 0 0"} y {$abc moveby "0 $d 0"} z {$abc moveby "0 0 $d"}}
	measure center $abc
	mmx
}
proc mto {x y z} {
	set abc	[atomselect top all]
	$abc moveby "[vecinvert [measure center $abc]]"
	$abc moveby "$x $y $z"
	measure center $abc
}
proc wpdb {x} {
	[atomselect top all] writepdb $x
}
proc mmx {} {
	measure minmax [atomselect top all] 
}
# 计算z轴最高点
proc mmx_select {selection_aaa} {
	measure minmax [atomselect top $selection_aaa] 
}
proc mmx_z_up {selection} {
	lindex [lindex [mmx_select $selection] 1] 2
}
# 计算z轴最低点
proc mmx_z_down {selection} {
	lindex [lindex [mmx_select $selection] 0] 2
}
proc mc {} {
	measure center [atomselect top all] 
}
proc re_name {a b} {
	[atomselect top "name $a"] set name $b
}
proc m_residue_xyz {atomselect c d} {
	set residue_list [[atomselect top $atomselect] get residue]
	set abc [atomselect top "residue $residue_list"]
	switch $c {x {$abc moveby "$d 0 0"} y {$abc moveby "0 $d 0"} z {$abc moveby "0 0 $d"}}
	measure center $abc
}
proc mxyz_2 {a c d} {
	set abc [atomselect top $a]
	switch $c {x {$abc moveby "$d 0 0"} y {$abc moveby "0 $d 0"} z {$abc moveby "0 0 $d"}}
	measure center $abc
	puts 	"up: [mmx_z_up $a]"
	puts 	"down: [mmx_z_down $a]"
}
proc resname_mxyz {a c d} {
	set abc [atomselect top "resname $a"]
	switch $c {x {$abc moveby "$d 0 0"} y {$abc moveby "0 $d 0"} z {$abc moveby "0 0 $d"}}
	measure center $abc
	puts 	"up: [mmx_z_up "resname $a"]"
	puts 	"down: [mmx_z_down "resname $a"]"
}

# residue  resid  
proc change_residue {b} {
	[atomselect top "residue $b"] set resid [expr $b+1]
}
proc change_residue_resid {range0 range1} {
	for {set j $range0} {$j <= $range1} {incr j} {
		change_residue $j
	}
}
proc resi_wpdb {resis_ids x} {
	[atomselect top "residue $resis_ids"] writepdb $x
}

proc clpdb {} {
	mol delete all
}
proc pbc_box {xxx yyyy zzzz} {
	molinfo top set { a b c} {$xxx $yyyy $zzzz}
	pbc box -on -center origin
}
proc no_resi_wpdb {resis_ids x} {
	[atomselect top "not residue $resis_ids"] writepdb $x
}
proc m_residue_xyz_linshi_up {c d} {
	set residue_list [[atomselect top "resname FOA and z>0"] get residue]
	set abc [atomselect top "residue $residue_list"]
	switch $c {x {$abc moveby "$d 0 0"} y {$abc moveby "0 $d 0"} z {$abc moveby "0 0 $d"}}
	measure center $abc
	puts 	"up: [mmx_z_up "resname FOA and z>0"]"
	puts 	"down: [mmx_z_down "resname FOA and z>0"]"
}

proc m_residue_xyz_linshi_down {c d} {
	set residue_list [[atomselect top "resname FOA and z<0"] get residue]
	set abc [atomselect top "residue $residue_list"]
	switch $c {x {$abc moveby "$d 0 0"} y {$abc moveby "0 $d 0"} z {$abc moveby "0 0 $d"}}
	measure center $abc
	puts 	"up: [mmx_z_up "resname FOA and z<0"]"
	puts 	"down: [mmx_z_down "resname FOA and z<0"]"
}


# this program can make the pdb structure straight on the interface

proc zangle_acos_simple {name_0 name_1} {
    set sel0m [measure center [atomselect top "name $name_0"]]
    set sel1m [measure center [atomselect top "name $name_1"]]
    expr acos([expr [vecdot {0 0 1} [vecsub $sel1m $sel0m]]/[veclength [vecsub $sel0m $sel1m]]])*360/6.2831852
}
proc trxyz_simple {x d} {
	set abc [atomselect top all]
	set cent [measure center $abc]
	$abc move [trans center "$cent" $x $d]
}
proc trans360_get_min {CA0 CA1 xyz} {
    for {set i 0} {$i<360} {incr i} {
        lappend list_angle [expr int([trxyz_get_angle_z $xyz 1 $CA0 $CA1])]
    }
    #puts $list_angle
    set second_value [lindex [lsort -unique -real $list_angle] 1]
    if {$second_value>=1} {
        set list_value [lindex [lsort -unique -real $list_angle] 0]
        puts "$second_value $list_value"
        set first_value [zangle_acos_simple $CA0 $CA1]
        puts "$first_value"
        while {$first_value>=$second_value} {
            trxyz_simple $xyz 1
            set first_value [zangle_acos_simple $CA0 $CA1]
        }
        puts "$first_value"
    } else {
        puts "$second_value"
    }
    trxyz_get_angle_z $xyz 1 $CA0 $CA1
}
#proc trxyz_get_angle_z {x d CA0 CA1} {
#    set abc [atomselect top all]
#    set cent [measure center $abc]
#    $abc move [trans center "$cent" $x $d]
#    set sel0m [measure center [atomselect top "name $CA0" ]]
#    set sel1m [measure center [atomselect top "name $CA1" ]]
#    expr acos([expr [vecdot {0 0 1} [vecsub $sel1m $sel0m]]/[veclength [vecsub $sel0m $sel1m]]])*360/6.2831852
#}

# Read the unit cell of a pdb and replicate n1 by n2 by n3 times.
# Use with: vmd -dispdev text -e replicateCrystal.tcl
# jcomer2@uiuc.edu

# Input:
#set unitCellPdb input3.pdb
# Output:
#set outPdb output3.pdb
# Parameters:
# Choose n1 and n2 even if you wish to use cutHexagon.tcl.
#set n1 9
#set n2 5
#set n3 1
#set l1 5.000
#set l2 10.000
#set l3 0.0
#set basisVector1 [list 1.0 0.0 0.0]
#set basisVector2 [list 0.0 1.0 0.0]
#set basisVector3 [list 0.0 0.0 0.0]

# Return a list with atom positions.
proc extractPdbCoords {pdbFile} {
	set r {}
	
	# Get the coordinates from the pdb file.
	set in [open $pdbFile r]
	foreach line [split [read $in] \n] {
		if {[string equal [string range $line 0 3] "ATOM"]} {
			set x [string trim [string range $line 30 37]]
			set y [string trim [string range $line 38 45]]
			set z [string trim [string range $line 46 53]]
			
			lappend r [list $x $y $z]
		}
	}
	close $in
	return $r
}

# Extract all atom records from a pdb file.
proc extractPdbRecords {pdbFile} {
	set in [open $pdbFile r]
	
	set pdbLine {}
	foreach line [split [read $in] \n] {
		if {[string equal [string range $line 0 3] "ATOM"]} {
			lappend pdbLine $line
		}
	}
	close $in	
	
	return $pdbLine
}

# Shift a list of vectors by a lattice vector.
proc displaceCell {rUnitName i1 i2 i3 a1 a2 a3} {
	upvar $rUnitName rUnit
	# Compute the new lattice vector.
	set rShift [vecadd [vecscale $i1 $a1] [vecscale $i2 $a2]]
	set rShift [vecadd $rShift [vecscale $i3 $a3]]
	
	set rRep {}
	foreach r $rUnit {
		lappend rRep [vecadd $r $rShift]
	}
	return $rRep
}

# Construct a pdb line from a template line, index, resId, and coordinates.
proc makePdbLine {template index resId r} {
	foreach {x y z} $r {break}
            set record "ATOM  "
            set si [string range [format "     %5i " $index] end-5 end]
            set temp0 [string range $template 12 21]
            set resId [string range "    $resId"  end-3 end]
            set temp1 [string range $template  26 29]
            set sx [string range [format "       %8.3f" $x] end-7 end]
            set sy [string range [format "       %8.3f" $y] end-7 end]
            set sz [string range [format "       %8.3f" $z] end-7 end]
            set tempEnd [string range $template 54 end]

	# Construct the pdb line.
	return "${record}${si}${temp0}${resId}${temp1}${sx}${sy}${sz}${tempEnd}"
}

# Build the crystal.
proc main_cell {unitCellPdb outPdb n1 n2 n3 l1 l2 l3} {

#set unitCellPdb input3.pdb
# Output:
#set outPdb output3.pdb
# Parameters:
# Choose n1 and n2 even if you wish to use cutHexagon.tcl.
#set n1 9
#set n2 5
#set n3 1
#set l1 5.000
#set l2 10.000
#set l3 0.0
	set basisVector1 [list 1.0 0.0 0.0]
	set basisVector2 [list 0.0 1.0 0.0]
	set basisVector3 [list 0.0 0.0 1.0]
#set basisVector1 [list 1.0 0.0 0.0]
#set basisVector2 [list 0 [expr sqrt(3.)/2.] 0.0]
#set basisVector3 [list 0.0 0.0 0.0]


	#global unitCellPdb outPdb
	#global n1 n2 n3 l1 l2 l3 basisVector1 basisVector2 basisVector3
		
	set out [open $outPdb w]
	puts $out "REMARK Unit cell dimensions:"
	puts $out "REMARK a1 $l1" 
	puts $out "REMARK a2 $l2" 
	puts $out "REMARK a3 $l3" 
	puts $out "REMARK Basis vectors:"
	puts $out "REMARK basisVector1 $basisVector1" 
	puts $out "REMARK basisVector2 $basisVector2" 
	puts $out "REMARK basisVector3 $basisVector3" 
	puts $out "REMARK replicationCount $n1 $n2 $n3" 
	
	set a1 [vecscale $l1 $basisVector1]
	set a2 [vecscale $l2 $basisVector2]
	set a3 [vecscale $l3 $basisVector3]
	
	set rUnit [extractPdbCoords $unitCellPdb]
	set pdbLine [extractPdbRecords $unitCellPdb]
	puts "\nReplicating unit $unitCellPdb cell $n1 by $n2 by $n3..."
		
	# Replicate the unit cell.
	set atom 1
	set resId 1
	for {set k 0} {$k < $n3} {incr k} {
    		for {set j 0} {$j < $n2} {incr j} {
			for {set i 0} {$i < $n1} {incr i} {
				set rRep [displaceCell rUnit $i $j $k $a1 $a2 $a3]
				
				# Write each atom.
				foreach r $rRep l $pdbLine {
					puts $out [makePdbLine $l $atom $resId $r]
					incr atom
				}
				incr resId
				
				if {$resId > 9999} {
					puts "Warning! Residue overflow."
					set resId 1
				}								
			}
		}
	}
	puts $out "END"
	close $out
	
	puts "The file $outPdb was written successfully."
}
proc rename_all {resname_1} {
	[atomselect top all] set resname $resname_1
}
proc get_resname {} {
	lsort -unique [[atomselect top all] get resname]
}
proc mxyz_down_to {down_value} {
	set 0_downvalue [lindex [lindex [mmx] 0] 2]
	puts $0_downvalue
	mxyz z [expr $down_value-$0_downvalue]
	mmx
	wpdb up.pdb
}
proc mxyz_up_to {up_value} {
	set 0_upvalue [lindex [lindex [mmx] 1] 2]
	puts $0_upvalue
	mxyz z [expr $up_value-$0_upvalue]
	mmx
	wpdb down.pdb
}
proc wpdb_99-9 {input_name} {
	mol new $input_name-99.pdb
	resi_wpdb " 10 13 16 37 40 43 64 67 70 " $input_name-99-9.pdb
	mol delete all
	mol new $input_name-99-9.pdb
}

proc wpdb_99-72 {input_name} {
	mol new $input_name-99.pdb
no_resi_wpdb "
10 13 16 37 40 43 64 67 70
" $input_name-99-72.pdb
	mol delete all
	mol new $input_name-99-72.pdb
}


proc wpdb_99-54 {input_name} {
	mol new $input_name-99.pdb
resi_wpdb "
0		2		4		6		8
9	10	11	12	13	14	15	16	17
	19		21		23		25	
27		29		31		33		35
36	37	38	39	40	41	42	43	44
	46		48		50		52	
54		56		58		60		62
63	64	65	66	67	68	69	70	71
	73		75		77		79	
" $input_name-99-54.pdb
	mol delete all
	mol new $input_name-99-54.pdb
}

proc wpdb_99-27 {input_name} {
	mol new $input_name-99.pdb
no_resi_wpdb "
0		2		4		6		8
9	10	11	12	13	14	15	16	17
	19		21		23		25	
27		29		31		33		35
36	37	38	39	40	41	42	43	44
	46		48		50		52	
54		56		58		60		62
63	64	65	66	67	68	69	70	71
	73		75		77		79	
" $input_name-99-27.pdb
	mol delete all
	mol new $input_name-99-27.pdb
}

proc wpdb_99-41 {input_name} {
	mol new $input_name-99.pdb
resi_wpdb "
0		2		4		6		8
	10		12		14		16	
18		20		22		24		26
	28		30		32		34	
36		38		40		42		44
	46		48		50		52	
54		56		58		60		62
	64		66		68		70	
72		74		76		78		80
" $input_name-99-41.pdb
	mol delete all
	mol new $input_name-99-41.pdb
}

proc wpdb_99-40 {input_name} {
	mol new $input_name-99.pdb
no_resi_wpdb "
0		2		4		6		8
	10		12		14		16	
18		20		22		24		26
	28		30		32		34	
36		38		40		42		44
	46		48		50		52	
54		56		58		60		62
	64		66		68		70	
72		74		76		78		80
" $input_name-99-40.pdb
	mol delete all
	mol new $input_name-99-40.pdb
}
proc wpdb_99 {input_name} {
	main_cell $input_name.pdb $input_name-99.pdb 9 9 1 5 5 0
	mol delete all
	mol new $input_name-99.pdb
	mto 0 0 0
	wpdb $input_name-99.pdb
	mol delete all
	mol new $input_name-99.pdb
	mc
}
proc measure_number-resname { res_name_all } {
	llength [lsort -unique [[atomselect top "resname $res_name_all"] get residue]]
}
proc rename_all {resname_1} {
	[atomselect top all] set resname $resname_1
}
proc get_resname {} {
	lsort -unique [[atomselect top all] get resname]
}
proc mxyz_down_to {down_value} {
	set 0_downvalue [lindex [lindex [mmx] 0] 2]
	puts $0_downvalue
	mxyz z [expr $down_value-$0_downvalue]
	mmx
	wpdb up.pdb
}
proc mxyz_up_to {up_value} {
	set 0_upvalue [lindex [lindex [mmx] 1] 2]
	puts $0_upvalue
	mxyz z [expr $up_value-$0_upvalue]
	mmx
	wpdb down.pdb
}
proc all-set-resname {res_name} {
    [atomselect top all] set resname $res_name
}

proc all-set-segname {seg_name} {
    [atomselect top all] set segname $seg_name 
}
proc wpdb-xyz { xxx yyy zzz outname } {
	set all_list [[atomselect top "x>[expr -1 * $xxx] and x<$xxx and y>[expr -1 * $yyy] and y<$yyy and z>[expr -1 * $zzz] and z<$zzz "] get residue]
	set residue_list [lsort -unique $all_list]
	[ atomselect top "residue $residue_list" ] writepdb $outname
}	
proc up-down-99 {inputname} {
	mol delete all
	wpdb_99 $inputname
	mol new $inputname-99.pdb
	mxyz_down_to 41.73
	trxyz x 180
	mxyz_up_to -41.3
	mol delete all
	mol new up.pdb
	mol new down.pdb
	mol new 668water.pdb
}	

proc up-down-water {inputname} {
	mol delete all
	mol new $inputname
	mto 0 0 0
	mxyz_down_to 41.73
	trxyz x 180
	mxyz_up_to -41.3
	mol delete all
	mol new up.pdb
	mol new down.pdb
	mol new 668water.pdb
}	

proc resname_log {} {
	set resname_list [lsort -unique [[atomselect top all] get resname]]
	set outfile [open resname.log w]
	puts $outfile "[pwd]"	
	echo "[pwd]"	
	puts $outfile "resname:$resname_list"
	echo "resname:$resname_list"
	foreach resname_xx $resname_list {
		puts $outfile "$resname_xx:"
		echo "$resname_xx:"
		puts $outfile "[llength [lsort -unique [[atomselect top "resname $resname_xx"] get residue]]]"
		echo "[llength [lsort -unique [[atomselect top "resname $resname_xx"] get residue]]]"
	}
	close $outfile
	# vi resname.log
}

proc name_number { c_1 } {
	set resname_list [lsort -unique [[atomselect top all] get resname]]
	set outfile [open name_num.log w]
	puts $outfile "#[pwd]"	
	puts $outfile "#resname:$resname_list"
	set max_num [llength $c_1]
	for {set i 0} { $i < $max_num } {incr i} {
		puts $outfile "set c_[expr $i+1] [lindex $c_1 $i]"
	}
	for {set i 0} { $i < $max_num } {incr i} {
		puts $outfile "#unset c_[expr $i+1]"
	}
	close $outfile
	vi name_num.log
}

proc up-down-water-33 {inputname} {
	mol delete all
	mol new $inputname
	mto 0 0 0
	mxyz_down_to 41.73
	trxyz x 180
	mxyz_up_to -41.3
	mol delete all
	mol new up.pdb
	mol new down.pdb
	mol new 338water.pdb
}
proc up-down-water-44 {inputname} {
	mol delete all
	mol new $inputname
	mto 0 0 0
	mxyz_down_to 41.73
	trxyz x 180
	mxyz_up_to -41.3
	mol delete all
	mol new up.pdb
	mol new down.pdb
	mol new 448water.pdb
}

proc wpdb_67 {input_name} {
	main_cell $input_name.pdb $input_name-99.pdb 6 7 1 5 5 0
	mol delete all
	mol new $input_name-67.pdb
	mto 0 0 0
	wpdb $input_name-67.pdb
	mol delete all
	mol new $input_name-67.pdb
	mc
}

proc mdall {} {
	mol delete all
}
proc mnew {input_name} {
	mol new $input_name
	resname_log
}
proc update_mytcl {} {
	source /home/ryan/tcl/tclb-2015-0706.tcl
}
proc mv {input_name output_name} {
	file rename $input_name $output_name
}

proc rm {input_name} {
	file delete $input_name 
}

proc cp {input_name path_name} {
	file copy $input_name $path_name
}

proc load_linshi {number} {
	mol delete all
	cd /home/ryan/namd-output/linshi/$number-l/moni
	mol new [glob input/run/*.psf]
	echo "load [glob input/run/*.psf]"
	mol addfile [glob output/dcd/*.dcd]
	echo "load [glob output/dcd/*.dcd]"
}

proc ls {} {
	glob *
}
proc auto_changename {} {
	set output_name [file tail [pwd]]
	echo [file tail [pwd]]
	echo "rename [glob *.psf] to [file tail [pwd]].psf"
	file rename [glob *.psf] [file tail [pwd]].psf
	echo "rename [glob *.dcd] to [file tail [pwd]].dcd"
	file rename [glob *.dcd] [file tail [pwd]].dcd
}
proc auto_mv_psf_dcd {} {
	set output_name [file tail [pwd]]
	echo [file tail [pwd]]
	echo "move [glob input/run/*.psf] to [file tail [pwd]].psf"
	file rename [glob input/run/*.psf] [file tail [pwd]].psf
	echo "rename [glob output/dcd/*.dcd] to [file tail [pwd]].dcd"
	file rename [glob output/dcd/*.dcd] [file tail [pwd]].dcd
	echo "delete input"
	file delete -force input/
	echo "delete output"
	file delete -force output/
	echo "delete new_command"
	file delete new_command
	
	echo "auto_load_svmd"
	auto_load_svmd
}
proc auto_load_svmd {} {
	mol delete all
	echo "delete all"
	mol new [glob *.psf]
	echo "mol new"
	mol addfile [glob *.dcd] step 1
	echo "mol add step 1"
	save_state step-1.vmd
	echo "save state"
	
	mol delete all
	echo "delete all"
	mol new [glob *.psf]
	echo "mol new"
	mol addfile [glob *.dcd] step 10
	echo "mol add step 10"
	save_state step-10.vmd
	echo "save state"
	
	mol delete all
}
# proc auto_play {_inputname} {
	# mol delete all
	# play step-$_inputname.vmd
# }

# ## mass density analysis auto tcl
proc auto_analysis_mass-density {} {
# 0 outputname
	set output_name [file tail [pwd]]
	echo 0
# 1 mol delete all
	mol delete all
	echo 1
# 2 load vmd
	play step-10.vmd
	echo 2
# 3 source tcl
	source /home/ryan/tcl/tcla/2015-0930/mass-density.tcl
	echo 3
# 4 run program? no mkdir 
	file mkdir mass-density-$output_name
	echo 4.1
	cd mass-density-$output_name
	echo 4.2
# 5 measure 
	auto_mass-density-resname $output_name
	echo 5
# 6 mol delete all
	mol delete all
	echo 6.1
	cd ..
	echo 6.2
}

proc auto_analysis_angle {} {
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
	source /home/ryan/tcl/tcla/2015-0930/zangle.tcl
	echo 3.1
	source name_num.log
	echo 3.2
# 4 run program? no mkdir 
	file mkdir zangle-$output_name
	echo 4.1
	cd zangle-$output_name
	echo 4.2
# 5 measure 
	# auto_mass-density-resname $output_name
	echo 5.1
	set head_zangle $c_9
	set tail_zangle $c_1
	set steps_zangle 1
	set resname_zangle DRG
	set position_name $c_9
	echo 5.2

	set min_z 00
	set max_z 200
	# set outputname 
	echo 5.3
	angle_ryan_0913 "resname $resname_zangle and z>$min_z and z<$max_z and name $position_name" up [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $head_zangle $tail_zangle acos 1 
	angle_ryan_0913 "resname $resname_zangle and z<[expr $min_z*(-1)] and z>[expr $max_z*(-1)] and name $position_name" down [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $head_zangle $tail_zangle acos 1 
	unset min_z max_z 
# 6 mol delete all
	mol delete all
	echo 6.1
	file copy /home/ryan/tcl/tcla/2015-0930/mangle.m .
	echo 6.2
	cd ..
	echo 6.3
	echo "system $output_name zangle done"
}
proc auto_analysis_scd {} {
# 0 outputname
	set output_name [file tail [pwd]]
	echo 0
# 1 mol delete all
	mol delete all
	echo 1
# 2 load vmd
	play step-10.vmd
	echo 2
# 3 source tcl
	source /home/ryan/tcl/tcla/2015-0930/scd.tcl
	echo 3.1
	source name_num.log
	echo 3.2
# 4 run program? no mkdir 
	file mkdir scd-$output_name
	echo 4.1
	cd scd-$output_name
	echo 4.2
# 5 measure 
	set start_frame 150
	# set end_frame 200
	set end_frame 151
	echo 5.1
	2015_scd-1-8 "resname DRG and z>0" $c_1 $c_2 $c_3 $c_4 $c_5 $c_6 $c_7 $c_8 $c_9 $start_frame $end_frame up-$output_name
	echo 5.2
	unset c_1   c_2  c_3  c_4  c_5  c_6  c_7  c_8  c_9 
	# set outputname 
	echo 5.3
# 6 mol delete all
	mol delete all
	echo 6.1
	cd ..
	echo 6.3
	echo "system $output_name scd done"
}
