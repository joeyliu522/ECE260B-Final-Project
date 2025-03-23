# Floorplan
floorPlan -site core -s 1400 1600 10.0 10.0 10.0 10.0
#floorPlan -site core -r 1 0.50 1.0 1.0 1.0 1.0

timeDesign -preplace -prefix preplace

globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose

#addRing -spacing {top 2 bottom 2 left 2 right 2} -width {top 3 bottom 3 left 3 right 3}  -layer {top M2 bottom M2 left M2 right M2} -center 1 -type core_rings -nets {VSS  VDD}

setAddStripeMode -break_at {block_ring}

### Note: Change the number of strip  by looking at the layout #########
addStripe -number_of_sets 10  -spacing 6 -layer M5 -width 2 -nets { VSS VDD }
################################################# 

setObjFPlanBox Instance kmem_instance 300 1100 1100 1500
setObjFPlanBox Instance qmem_instance 300 600 1100 1000
setObjFPlanBox Instance psum_mem_instance 300 100 1100 500

addHaloToBlock {50 50 50 50} qmem_instance
addHaloToBlock {50 50 50 50} kmem_instance
addHaloToBlock {50 50 50 50} psum_mem_instance

#addRing -type block_rings -nets {VSS VDD} -around each_block -spacing {top 0.5 bottom 0.5 left 0.5 right 0.5} -width {top 1 bottom 1 left 1 right 1} -layer {top M1 bottom M1 left M2 right M2}

globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose

globalNetConnect VDD -type pgpin -pin VDD -sinst qmem_instance -verbose -override
globalNetConnect VSS -type pgpin -pin VSS -sinst qmem_instance -verbose -override 

globalNetConnect VDD -type pgpin -pin VDD -sinst kmem_instance -verbose -override
globalNetConnect VSS -type pgpin -pin VSS -sinst kmem_instance -verbose -override   

globalNetConnect VDD -type pgpin -pin VDD -sinst psum_mem_instance -verbose -override
globalNetConnect VSS -type pgpin -pin VSS -sinst psum_mem_instance -verbose -override  
 
sroute


