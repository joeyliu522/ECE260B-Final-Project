streamOut fullchip.gds2
write_lef_abstract fullchip.lef
defOut -netlist -routing fullchip.def
saveNetlist fullchip.pnr.v

setAnalysisMode -setup
set_analysis_view -setup WC_VIEW -hold WC_VIEW
do_extract_model -view WC_VIEW -format dotlib fullchip_WC.lib
write_sdf -view WC_VIEW fullchip_WC.sdf

setAnalysisMode -hold
set_analysis_view -setup BC_VIEW -hold BC_VIEW
do_extract_model -view BC_VIEW -format dotlib fullchip_BC.lib
write_sdf -view BC_VIEW fullchip_BC.sdf
