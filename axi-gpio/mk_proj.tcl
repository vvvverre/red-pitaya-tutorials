set projectname "axi-gpio"
set outputdir "./$projectname"
set part xc7z010-1clg400

# Create output directory and clear contents
file mkdir $outputdir
set files [glob -nocomplain "$outputdir/*"]
if {[llength $files] != 0} {
    puts "Deleting contents of $outputdir"
    file delete -force {*}[glob -directory $outputdir *]; # clear folder contents
} else {
    puts "$outputdir is empty"
}

# Create project
create_project -part $part $projectname $outputdir

source ./../src/bd/axi_gpio.tcl

make_wrapper -files [get_files /home/wouter/git/red-pitaya-tutorials/axi-gpio/vivado/axi-gpio/axi-gpio.srcs/sources_1/bd/axi_gpio/axi_gpio.bd] -top
add_files -norecurse /home/wouter/git/red-pitaya-tutorials/axi-gpio/vivado/axi-gpio/axi-gpio.srcs/sources_1/bd/axi_gpio/hdl/axi_gpio_wrapper.v

read_xdc ../src/xdc/constraints.xdc

set_property top "${bd_name}_wrapper" [current_fileset]
update_compile_order -fileset sources_1


#Run implementation and generate bitstream
set_property STEPS.PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
