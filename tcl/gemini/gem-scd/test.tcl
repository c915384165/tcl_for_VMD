set list_001 [[atomselect top "resname GE01"] get resid]
# echo "list_001: $list_001"
set list_001_lsort [lsort -unique -integer $list_001] 
# echo "list_001_lsort: $list_001_lsort"
set llength_list [llength $list_001_lsort]
# echo "llength_list: $llength_list"
for {set i 1} {$i < $llength_list} {incr i} {
	if {[llength $list_001_lsort] >1} {
		set first_lindex [lindex $list_001_lsort 0]
		set list_001_lsort [lreplace $list_001_lsort 0 0]
		# puts "$first_lindex $list_001_lsort"
		foreach list_xxx $list_001_lsort {
			# lappend c22_list [vector_cos $first_lindex $list_xxx CBY CCC 0]
			puts [vector_cos $first_lindex $list_xxx CBY CCC 0]
		}
	} else {
	}
}
# expr [average $c22_list]