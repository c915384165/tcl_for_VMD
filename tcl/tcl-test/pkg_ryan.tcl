# 找相同元素 只限整数
proc list_find_repeat_times {list_0 repeat_val} {
	llength [lsearch -all -inline -exact -integer $list_0 $repeat_val]
}
proc list_max_integer {list_value} {
	expr max([join $list_value ,])
}
set a {1 1 1 1 3 3 3 3 4 4 4 4 4 4 5 5 5 5   9 9 9 999 999 222 -34}
list_max_integer $a
# 查找大于选定之的量 如果没 则输出 没有
proc list_find_repeat_all {list_all value_0} {
	set sorted_list [lsort -integer $list_all]
	set key_sorted_list [lsort -unique -integer $list_all]
	foreach key_0 $key_sorted_list {
		set longth($key_0) [list_find_repeat_times $list_all $key_0]
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
	# puts $selected_list
	# split $selected_list
# }

list_find_repeat_all $a 2 
