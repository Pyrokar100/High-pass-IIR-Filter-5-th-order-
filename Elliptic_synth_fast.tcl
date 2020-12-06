## Setup technology files
include ../Source/FILTER/X-FAB_fast.tcl
## Setup variables
set DESIGN Elliptic
set PARAMS {}
## Read in Verilog HDL files
# IIR filter
read_hdl -v2001 ../Source/FILTER/Elliptic.v
## Compile our code (create a technology-independent schematic)
elaborate -parameters $PARAMS $DESIGN
## Setup design constraints
read_sdc ../Source/FILTER/Elliptic.sdc
## Synthesize our schematic (create a technology-dependent schematic)
synthesize -to_generic
synthesize -to_mapped
synthesize -incremental
## Write out area and timing reports
report timing > ../Reports5/Elliptic_synth_timing_report_14MHz_5unc_fast
report area > ../Reports5/Elliptic_synth_area_report_14MHz_5unc_fast
## Write out synthesized Verilog netlist
#write_hdl -mapped > ../Source/FILTER/Synthesis/Elliptic_synth14_5.v
## Write out the SDC file we will take into the place n route tool
##write_sdc > ../Source/FILTER/Synthesis/Elliptic_out.sdc
gui_show

