## Setup technology files
include ../Scripts/X-FAB_slow.tcl
## Setup variables
set DESIGN Elliptic
set PARAMS {}
## Read in Verilog HDL files
# IIR filter
read_hdl -v2001 ../Source/Elliptic.v
## Compile our code (create a technology-independent schematic)
elaborate -parameters $PARAMS $DESIGN
## Setup design constraints
read_sdc ../Source/Elliptic.sdc
## Synthesize our schematic (create a technology-dependent schematic)
synthesize -to_generic
synthesize -to_mapped
synthesize -incremental
## Write out area and timing reports
report timing > ../Reports/Elliptic_synth_timing_report_14MHz_5unc_slow
report area > ../Reports/Elliptic_synth_area_report_14MHz_5unc_slow
gui_show

