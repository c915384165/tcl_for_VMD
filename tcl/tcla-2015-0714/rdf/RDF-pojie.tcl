# 框架

set rdf  [toplevel .rdfcalc]
wm title $rdf "RDF calculation"

# 变量
# Frame: startnum, endnum, skipnum, framenum
# Atoms: Segname_from, Resname_from, Name_from
# Atoms: Segname_to, Resname_to, Name_to
# Regional: cutoff, mbin
# Box: box_x, box_y, box_z 
# Control commands: Start Quit Cancel
# Data: set as global, rdfdata store data, sets is the frame index 
# rdfdata is used to store the accumulation number of atoms
# which rdffunc is used to store the g(r) value

set rdfdata(0) 0
set rdffunc(0) 0
set M_PI
set box_x 0
set box_y 0
set box_z 0

#number of trajectory frames
set framenum [molinfo top get numframes]

#construct the user interface
#create a frame for trajectory frame numbers
frame $rdf.top -borderwidth 10 -relief raised
pack $rdf.top -side top -fill x

# Create the region showing total frame number 
label $rdf.top.l -text "Total $framenum Frames "  -relief sunken
pack $rdf.top.l -side top 

# 变量框架 格子
foreach key { start end skip } {
frame $rdf.top.$key -borderwidth 10
label $rdf.top.$key.l -text "$key"
entry $rdf.top.$key.frame -width 8 -relief  sunken -background pink 
pack $rdf.top.$key -side left
pack $rdf.top.$key.l $rdf.top.$key.frame -side top

}

# 变量框架 格子
#frame for Atom information
frame $rdf.atominfo -borderwidth 10 
pack $rdf.atominfo -side top
foreach atom  { from to } {
	frame $rdf.atominfo.$atom -borderwidth 10
	label $rdf.atominfo.$atom.l  -text " $atom atom "
	pack $rdf.atominfo.$atom.l -side top -fill x
	foreach key { segname resname name } {
		frame $rdf.atominfo.$atom.$key 
		label $rdf.atominfo.$atom.$key.l -text "$key"
		entry $rdf.atominfo.$atom.$key.key -relief sunken -width 8 -background yellow
		pack $rdf.atominfo.$atom.$key.l $rdf.atominfo.$atom.$key.key -side left
		pack $rdf.atominfo.$atom.$key -side top
		}
	pack $rdf.atominfo.$atom -side left 
} 

#Frame for data infomation 
# All these data are accessed by frame_RDF function
frame $rdf.data -borderwidth 10
frame $rdf.data.cutoff
	label $rdf.data.cutoff.l -text "Cutoff"
	entry $rdf.data.cutoff.num -width 8 -background black -foreground white
pack $rdf.data.cutoff.l $rdf.data.cutoff.num -side top

frame $rdf.data.mbin 
	label $rdf.data.mbin.l -text "mbin"
	entry $rdf.data.mbin.num -width 8 -background black -foreground white
pack $rdf.data.mbin.l $rdf.data.mbin.num -side top
pack $rdf.data -side top
pack $rdf.data.cutoff $rdf.data.mbin -side left

# Frame for boundary information
# Not implemented, so just disabled the entry part
frame $rdf.boundary -borderwidth 10
pack $rdf.boundary -side top
label $rdf.boundary.l -text "Box Dimension"
#label $rdf.boundary.l2 -text " PBC NOT IMPLEMENTED " -foreground red
pack $rdf.boundary.l -side top -fill x

foreach dimension { x y z } {
	frame $rdf.boundary.$dimension
	label $rdf.boundary.$dimension.l -text "$dimension" 
	entry $rdf.boundary.$dimension.num  -width 8 -background gold 
	pack $rdf.boundary.$dimension.l $rdf.boundary.$dimension.num -side top
	pack $rdf.boundary.$dimension -side left
}
	

# Frame for command button
frame $rdf.cmdbutton 
button $rdf.cmdbutton.run -text "Run RDF" -command Run 
button $rdf.cmdbutton.quit -text "Quit" -command "quitRDF"
button $rdf.cmdbutton.save -text "Save RDF" -command "printrdf"
pack  $rdf.cmdbutton.run $rdf.cmdbutton.save -side left
pack $rdf.cmdbutton.quit -side right
pack $rdf.cmdbutton -side top
# Frame for file
frame $rdf.file
label $rdf.file.label -text "Input the file name"
entry $rdf.file.name -width 20
pack  $rdf.file.label $rdf.file.name -side top
pack $rdf.file -side top

