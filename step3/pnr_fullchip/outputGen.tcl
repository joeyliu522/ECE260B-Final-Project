streamOut core.gds2 -merge {./subckt/sram_w16.gds2}

write_lef_abstract core.lef
defOut -netlist -routing core.def
saveNetlist core.pnr.v

setAnalysisMode -setup
set_analysis_view -setup WC_VIEW -hold WC_VIEW
do_extract_model -view WC_VIEW -format dotlib core_WC.lib
write_sdf -view WC_VIEW core_WC.sdf

setAnalysisMode -hold
set_analysis_view -setup BC_VIEW -hold BC_VIEW
do_extract_model -view BC_VIEW -format dotlib core_BC.lib
write_sdf -view BC_VIEW core_BC.sdf
