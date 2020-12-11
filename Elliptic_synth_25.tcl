## Setup technology files
include ../Scripts/X-FAB_typ.tcl
## Setup variables
set DESIGN Elliptic
set PARAMS {}
## Read in Verilog HDL files
# IIR filter
read_hdl -v2001 ../Source/Elliptic.v
## Compile our code (create a technology-independent schematic)
elaborate -parameters $PARAMS $DESIGN
## Setup design constraints
read_sdc ../Source/Elliptic_25.sdc
## Synthesize our schematic (create a technology-dependent schematic)
synthesize -to_generic
synthesize -to_mapped
synthesize -incremental
## Write out synthesized Verilog netlist
write_hdl -mapped > ../Outputs/Elliptic_synth.v
gui_show

