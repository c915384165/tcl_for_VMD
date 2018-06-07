#proc test1535 {atomsel_list} {
	set atomsel_list "resname GEA SOL"
	echo "test begin"
	# puts "[lsort -unique [[atomselect top $atomsel_list] get resname]]"
	# puts "[lsort -unique -integer [[atomselect top $atomsel_list] get resid]]"
	puts "[lsort -unique -integer [[atomselect top $atomsel_list] get residue]]"