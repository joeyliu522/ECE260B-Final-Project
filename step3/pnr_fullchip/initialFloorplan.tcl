# Floorplan
#floorPlan -site core -r 1 0.50 10.0 10.0 10.0 10.0
floorplan -site core -s 1200 1200 10 10 50 10


timeDesign -preplace -prefix preplace

globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose

addRing -spacing {top 2 bottom 2 left 2 right 2} -width {top 3 bottom 3 left 3 right 3}  -layer {top M2 bottom M2 left M2 right M2} -center 1 -type core_rings -nets {VSS  VDD}

setAddStripeMode -break_at {block_ring}

### Note: Change the number of strip  by looking at the layout #########
#addStripe [fill out]
#addStripe -nets {VDD VSS} -layer M5 -direction horizontal -width 1.8 -spacing 1.8 -number_of_sets 5 
addStripe -nets {VDD VSS} -layer M7 -direction horizontal -width 2 -spacing 6 -number_of_sets 35 -start_from left -start 20 -stop 1180
#################################################


#setObjFPlanBox Instance core_instance/kmem_instance 50 900 200 1000
#setObjFPlanBox Instance core_instance/qmem_instance 50 550 200 800
#setObjFPlanBox Instance core_instance/psum_mem_instance 50 50 200 200

setObjFPlanBox Instance core_instance/kmem_instance 182.2255 849.485 404.0255 1071.085
setObjFPlanBox Instance core_instance/qmem_instance 744.5255 858.2385 966.3255 1079.8385
setObjFPlanBox Instance core_instance/psum_mem_instance 606.478 112.148 828.278 333.748


addHaloToBlock {3 3 3 3} core_instance/qmem_instance
addHaloToBlock {3 3 3 3} core_instance/kmem_instance
addHaloToBlock {3 3 3 3} core_instance/psum_mem_instance



#addRing -nets {VDD VSS} -type block_rings -around each_block -layer {top M1 bottom M1 left M2 right M2} -width {top 0.5 bottom 0.5 left 0.5 right 0.5} -spacing {top 0.5 bottom 0.5 left 0.5 right 0.5} 
addRing -type block_rings -nets {VSS VDD} -around each_block -spacing {top 0.5 bottom 0.5 left 0.5 right 0.5} -width {top 1 bottom 1 left 1 right 1} -layer {top M1 bottom M1 left M2 right M2}


globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose


globalNetConnect VDD -type pgpin -pin VDD -sinst core_instance/qmem_instance -verbose -override
globalNetConnect VSS -type pgpin -pin VSS -sinst core_instance/qmem_instance -verbose -override 

globalNetConnect VDD -type pgpin -pin VDD -sinst core_instance/kmem_instance -verbose -override
globalNetConnect VSS -type pgpin -pin VSS -sinst core_instance/kmem_instance -verbose -override   

globalNetConnect VDD -type pgpin -pin VDD -sinst core_instance/psum_mem_instance -verbose -override
globalNetConnect VSS -type pgpin -pin VSS -sinst core_instance/psum_mem_instance -verbose -override   
sroute


