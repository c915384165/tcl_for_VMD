source ryan_newangle.tcl
source ../name_num.log
set steps_zangle 10
set resname_zangle DRG
set position_name $c_12

set min_z 00
set max_z 200
set outputname $steps_zangle-$min_z-$max_z
angle_ryan_0913 "resname $resname_zangle and z>$min_z and z<$max_z and name $position_name" up-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
angle_ryan_0913 "resname $resname_zangle and z<[expr $min_z*(-1)] and z>[expr $max_z*(-1)] and name $position_name" down-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
unset min_z max_z outputname

set min_z 10
set max_z 200
set outputname $steps_zangle-$min_z-$max_z
angle_ryan_0913 "resname $resname_zangle and z>$min_z and z<$max_z and name $position_name" up-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
angle_ryan_0913 "resname $resname_zangle and z<[expr $min_z*(-1)] and z>[expr $max_z*(-1)] and name $position_name" down-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
unset min_z max_z outputname

set min_z 20
set max_z 200
set outputname $steps_zangle-$min_z-$max_z
angle_ryan_0913 "resname $resname_zangle and z>$min_z and z<$max_z and name $position_name" up-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
angle_ryan_0913 "resname $resname_zangle and z<[expr $min_z*(-1)] and z>[expr $max_z*(-1)] and name $position_name" down-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
unset min_z max_z outputname

set min_z 30
set max_z 200
set outputname $steps_zangle-$min_z-$max_z
angle_ryan_0913 "resname $resname_zangle and z>$min_z and z<$max_z and name $position_name" up-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
angle_ryan_0913 "resname $resname_zangle and z<[expr $min_z*(-1)] and z>[expr $max_z*(-1)] and name $position_name" down-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
unset min_z max_z outputname

set min_z 40
set max_z 200
set outputname $steps_zangle-$min_z-$max_z
angle_ryan_0913 "resname $resname_zangle and z>$min_z and z<$max_z and name $position_name" up-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
angle_ryan_0913 "resname $resname_zangle and z<[expr $min_z*(-1)] and z>[expr $max_z*(-1)] and name $position_name" down-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
unset min_z max_z outputname

set min_z 50
set max_z 200
set outputname $steps_zangle-$min_z-$max_z
angle_ryan_0913 "resname $resname_zangle and z>$min_z and z<$max_z and name $position_name" up-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
angle_ryan_0913 "resname $resname_zangle and z<[expr $min_z*(-1)] and z>[expr $max_z*(-1)] and name $position_name" down-$outputname [expr 1500/$steps_zangle] [expr 2000/$steps_zangle] $c_12 $c_1 acos 1 
unset min_z max_z outputname

unset steps_zangle resname_zangle position_name 
unset c_1 
unset c_2 
unset c_3 
unset c_4 
unset c_5 
unset c_6 
unset c_7 
unset c_8 
unset c_9 
unset c_10 
unset c_11 
unset c_12 
unset c_13 