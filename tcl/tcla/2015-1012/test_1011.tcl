set sel_i0 [atomselect top "index 0" ]
set sel_i1_f1500 [atomselect top "index 1" frame 1500]
set sel_i1_f1600 [atomselect top "index 1" frame 1600]
puts [measure rmsf $sel_i0 first 1500 last 1506 step 3]
puts [measure rmsd $sel_i1_f1500 $sel_i1_f1600]
# proc posi_index_frame {index_xx frame_xx} {
	# measure center [atomselect top "index $index_xx" frame frame_xx]
# }
proc posi_replace_index_frame0_frame_1 {index_xx frame_0 frame_1} {
	puts [veclength [vecsub [measure center [atomselect top "index $index_xx" frame $frame_1]] [measure center [atomselect top "index $index_xx" frame $frame_0]]]]
}
# posi
# puts [posi_index_frame 2 1500]
# puts [posi_index_frame 2 1605]

posi_replace_index_frame0_frame_1 0 1500 1503
posi_replace_index_frame0_frame_1 0 1503 1506
posi_replace_index_frame0_frame_1 0 1502 1503
posi_replace_index_frame0_frame_1 0 1503 1504
posi_replace_index_frame0_frame_1 0 1504 1505
posi_replace_index_frame0_frame_1 0 1505 1506
posi_replace_index_frame0_frame_1 0 1506 1507
posi_replace_index_frame0_frame_1 0 1500 1506
# posi_replace_index_frame0_frame_1 0 1500 1506
# for 
# puts [measure center [atomselect top "index 0" frame 1500]]
# puts [measure center [atomselect top "index 0" frame 1509]]
