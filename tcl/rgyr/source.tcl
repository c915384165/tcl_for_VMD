source rgyr-select.tcl
set resname_rgyr DRG
set c_1  CBT
set c_2  CBI
set c_3  CBJ
set c_4  CBK
set c_5  CBL
set c_6  CBM
set c_7  CBN
set c_8  CBO
set c_9  CBP
set c_10 CBQ
set c_11 CBR
set c_12 CBS
set start_frame 150
set end_frame 200
0912-rgyr_ryan "resname $resname_rgyr" "$c_1 $c_2 $c_3 $c_4 $c_5 $c_6 $c_7 $c_8 $c_9 $c_10 $c_11 $c_12" $start_frame $end_frame rgyr.dat
# 0912-rgyr_ryan "resname DRG and z>0" "CBI CBK CBM CBO CBQ CBS CBT CBR CBP CBN CBL CBJ" 0 1 rgyr_up2.dat
unset c_1   c_2  c_3  c_4  c_5  c_6  c_7  c_8  c_9  c_10  c_11  c_12