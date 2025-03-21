#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Mar 14 12:58:03 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v15.23-s045_1 (64bit) 04/22/2016 12:32 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 15.23-s045_1 NR160414-1105/15_23-UB (database version 2.30, 317.6.1) {superthreading v1.26}
#@(#)CDS: AAE 15.23-s014 (64bit) 04/22/2016 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 15.23-s022_1 () Apr 22 2016 09:38:45 ( )
#@(#)CDS: SYNTECH 15.23-s008_1 () Apr 12 2016 21:52:59 ( )
#@(#)CDS: CPE v15.23-s045
#@(#)CDS: IQRC/TQRC 15.1.4-s213 (64bit) Tue Feb  9 17:31:28 PST 2016 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set init_pwr_net VDD
set init_gnd_net VSS
set init_verilog ./netlist/sram_w16.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell sram_w16
set init_lef_file /home/linux/ieng6/ee260bwi24/public/PDKdata/lef/tcbn65gplus_8lmT2.lef
create_library_set -name WC_LIB -timing $worst_timing_lib
set init_pwr_net VDD
set init_gnd_net VSS
set init_verilog ./netlist/sram_w16.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell sram_w16
set init_lef_file /home/linux/ieng6/ee260bwi25/public/PDKdata/lef/tcbn65gplus_8lmT2.lef
create_library_set -name WC_LIB -timing $worst_timing_lib
create_library_set -name BC_LIB -timing $best_timing_lib
create_rc_corner -name Cmax -cap_table $worst_captbl -T 125
create_rc_corner -name Cmin -cap_table $best_captbl -T -40
create_delay_corner -name WC -library_set WC_LIB -rc_corner Cmax
create_delay_corner -name BC -library_set BC_LIB -rc_corner Cmin
create_constraint_mode -name CON -sdc_file [list $sdc]
create_analysis_view -name WC_VIEW -delay_corner WC -constraint_mode CON
create_analysis_view -name BC_VIEW -delay_corner BC -constraint_mode CON
init_design -setup WC_VIEW -hold BC_VIEW
set_interactive_constraint_modes {CON}
setDesignMode -process 65
floorPlan -site core -r 1 0.50 1.0 1.0 1.0 1.0
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
setAddStripeMode -break_at block_ring
addStripe -number_of_sets 2 -spacing 1 -layer M4 -width 1 -nets { VSS VDD }
sroute
fit
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch false
floorPlan -site core -r 1 0.50 1.0 1.0 1.0 1.0
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
setAddStripeMode -break_at block_ring
addStripe -number_of_sets 2 -spacing 1 -layer M4 -width 1 -nets { VSS VDD }
sroute
selectWire 1.0000 22.4350 220.8000 22.7650 1 VDD
deselectAll
zoomIn
zoomIn
zoomIn
fit
zoomSelected
gui_select -rect {-8.650 223.718 37.593 198.267}
zoomSelected
zoomIn
zoomIn
floorPlan -site core -r 1 0.50 1.0 1.0 1.0 1.0
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
setAddStripeMode -break_at block_ring
addStripe -nets {VDD VSS} -layer M4 -direction vertical -width 1.8 -spacing 1.8 -number_of_sets 5 -start_from left -start 80 -stop 180
sroute
deselectAll
fit
floorPlan -site core -r 1 0.50 0.50 0.50 0.50 0.50
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
setAddStripeMode -break_at block_ring
addStripe -nets {VDD VSS} -layer M4 -direction vertical -width 1.8 -spacing 1.8 -number_of_sets 5 -start_from left -start 80 -stop 180
sroute
selectWire 0.6000 23.8350 220.4000 24.1650 1 VSS
floorPlan -site core -r 1 0.50 1.0 1.0 1.0 1.0
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
setAddStripeMode -break_at block_ring
addStripe -nets {VDD VSS} -layer M4 -direction horizontal -width 1.8 -spacing 1.8 -number_of_sets 8 -start_from left -start 20 -stop 200
sroute
deselectAll
