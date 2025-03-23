

verifyGeometry
verifyConnectivity

# Timing report
report_timing -max_paths 5 > fullchip.post_route.timing.rpt

# Power report
report_power -outfile fullchip.post_route.power.rpt

# Design report
summaryReport -nohtml -outfile fullchip.post_route.summary.rpt


