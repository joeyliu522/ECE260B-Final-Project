#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Tue Mar 18 03:20:04 2025                
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
set init_verilog ./netlist/core.out.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell core
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
addRing -spacing {top 1 bottom 1 left 1 right 1} -width {top 2 bottom 2 left 2 right 2} -layer {top M1 bottom M1 left M2 right M2} -center 1 -type core_rings -nets {VSS  VDD}
setAddStripeMode -break_at block_ring
addStripe -number_of_sets 3 -spacing 6 -layer M5 -width 2 -nets {VSS VDD}
setObjFPlanBox Instance qmem_instance 27.5 75 42.5 90
setObjFPlanBox Instance kmem_instance 27.5 45 42.5 30
setObjFPlanBox Instance psum_mem_instance 27.5 45 42.5 30
addHaloToBlock {3 3 3 3} add_instance0
floorPlan -site core -r 1 0.50 1.0 1.0 1.0 1.0
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
addRing -spacing {top 1 bottom 1 left 1 right 1} -width {top 2 bottom 2 left 2 right 2} -layer {top M1 bottom M1 left M2 right M2} -center 1 -type core_rings -nets {VSS  VDD}
setAddStripeMode -break_at block_ring
addStripe -number_of_sets 3 -spacing 6 -layer M5 -width 2 -nets {VSS VDD}
setObjFPlanBox Instance qmem_instance 27.5 75 42.5 90
setObjFPlanBox Instance kmem_instance 27.5 45 42.5 30
setObjFPlanBox Instance psum_mem_instance 27.5 45 42.5 30
addRing -nets {VDD VSS} -type block_rings -around each_block -layer {top M1 bottom M1 left M2 right M2} -width {top 0.5 bottom 0.5 left 0.5 right 0.5} -spacing {top 0.5 bottom 0.5 left 0.5 right 0.5}
sroute
addHaloToBlock -help
floorPlan -site core -r 1 0.50 1.0 1.0 1.0 1.0
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
addRing -spacing {top 1 bottom 1 left 1 right 1} -width {top 2 bottom 2 left 2 right 2} -layer {top M1 bottom M1 left M2 right M2} -center 1 -type core_rings -nets {VSS  VDD}
setAddStripeMode -break_at block_ring
addStripe -number_of_sets 3 -spacing 6 -layer M5 -width 2 -nets {VSS VDD}
setObjFPlanBox Instance qmem_instance 27.5 75 42.5 90
setObjFPlanBox Instance kmem_instance 27.5 45 42.5 30
setObjFPlanBox Instance psum_mem_instance 27.5 45 42.5 30
addHaloToBlock {3 3 3 3} qmem_instance
autoGenRelativeFPlan -help
