set projectname "led-control"
set outputdir ./vivado/
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

source ./src/bd/led_control.tcl

