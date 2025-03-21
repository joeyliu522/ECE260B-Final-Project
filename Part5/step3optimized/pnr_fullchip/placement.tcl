# Placement
saveDesign floorplan.enc
setPlaceMode -timingDriven true -reorderScan false -congEffort medium -modulePlan True -placeIOpins false
setOptMode -effort medium -powerEffort high -leakageToDynamicRatio 0.5 -fixFanoutLoad true -restruct false -verbose true
place_opt_design

#addFiller -cell {DCAP DCAP4 DCAP8 DCAP16 DCAP32} -merge true

saveDesign placement.enc
