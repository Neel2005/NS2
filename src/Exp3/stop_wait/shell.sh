
#!/bin/bash
ns snw.tcl 5Mb 50ms
awk -v bw=5000000 -v rtt=0.100 -f snw.awk A1-stop-n-wait.tr
ns snw.tcl 4.5Mb 75ms
awk -v bw=4500000 -v rtt=0.150 -f snw.awk A1-stop-n-wait.tr
ns snw.tcl 4Mb 100ms
awk -v bw=4000000 -v rtt=0.200 -f snw.awk A1-stop-n-wait.tr
ns snw.tcl 3.5Mb 125ms
awk -v bw=3500000 -v rtt=0.250 -f snw.awk A1-stop-n-wait.tr
ns snw.tcl 3Mb 150ms
awk -v bw=3000000 -v rtt=0.300 -f snw.awk A1-stop-n-wait.tr
ns snw.tcl 2.5Mb 175ms
awk -v bw=2500000 -v rtt=0.350 -f snw.awk A1-stop-n-wait.tr
ns snw.tcl 2Mb 200ms
awk -v bw=2000000 -v rtt=0.400 -f snw.awk A1-stop-n-wait.tr
ns snw.tcl 1.5Mb 225ms
awk -v bw=1500000 -v rtt=0.450 -f snw.awk A1-stop-n-wait.tr
ns snw.tcl 1Mb 250ms
awk -v bw=1000000 -v rtt=0.500 -f snw.awk A1-stop-n-wait.tr
