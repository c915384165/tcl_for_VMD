
# 1 change resid by residue
proc gem_change_resid_by_residue {resname_select} {
	set resid_all_number [llength [lsort -unique [[atomselect top all] get resid]]]
	puts "resids are $resid_all_number"
	set residue_list [lsort -unique -integer [[atomselect top "resname $resname_select"] get residue]]
	puts "residue_list are $residue_list"
	foreach residue_xx $residue_list {
		[atomselect top "resname $resname_select and residue $residue_xx"] set resid [expr $residue_xx+1]
		puts "resname $resname_select residue $residue_xx set resid [expr $residue_xx+1]"
	}
}
# 2 change part to resid more
proc gem_change_resid {resname_select name_select} {
	set residue_all_number [llength [lsort -unique [[atomselect top all] get residue]]]
	puts "residues are $residue_all_number"
	set resid_all_number [llength [lsort -unique [[atomselect top all] get resid]]]
	puts "resids are $resid_all_number"
	set resid_list [lsort -unique -integer [[atomselect top "name $name_select"] get resid]]
	puts "resid_list are $resid_list"
	foreach resid_xx $resid_list {
		[atomselect top "name $name_select and resid $resid_xx"] set resid [expr $resid_xx+$residue_all_number]
		puts "name $name_select resid $resid_xx set [expr $resid_xx+$residue_all_number]"
	}
}
# 3 change name
proc change_name_1_2 {name_01 name_02} {
	[atomselect top "name $name_01"] set name $name_02
}
# 4 检查输出结果
proc resname_getresid_and_length {resname_select} {
	puts "list: [lsort -unique -integer [[atomselect top "resname $resname_select"] get resid]]"
	puts "resids: [llength [lsort -unique -integer [[atomselect top "resname $resname_select"] get resid]]]"
}

# 1 bianliang
echo "load resname and name"
source ./resname.tcl
source ./name_num.tcl
echo "load done"

# 2 
echo "2 change resid by residue"
gem_change_resid_by_residue $gemini_name
echo "2 done"

# 3 change part to resid 
echo "3 change selection name id"
echo "3.1 set begin number and end number"

set half_length [expr [array size arrC]/2]
set full_length [array size arrC]
set begin_number [expr $half_length+1]
set end_number $full_length

echo "3.1 done"
echo "3.2 begin for loop"
# echo "3.2 begin for loop test"
for {set i $begin_number} {$i <= $end_number} {incr i} {
	# puts $arrC($i)
	gem_change_resid $gemini_name $arrC($i)
}
echo "loop end"

# 4 change name
echo "begin to change name"
echo "begin loop"

for {set j 1} {$j <= $half_length} {incr j} {
	echo "changing name $arrC($j) $arrC([expr $j+$half_length])"
	change_name_1_2 $arrC($j) $arrC([expr $j+$half_length])
}
echo "loop end"

# 5 检查

echo "检查"
resname_getresid_and_length $gemini_name

# 6 source scd-gem.tcl
# source scd-gem.tcl
