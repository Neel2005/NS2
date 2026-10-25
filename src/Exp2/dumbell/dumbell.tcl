
# ============================================================
# NS-2 Dumbbell Topology with 5 TCP/FTP Flows
# Output files: dumbell.tr and dumbell.nam
# ============================================================

# Create simulator
set ns [new Simulator]

# Open trace files
set nr [open "dumbell.tr" w]
set nf [open "dumbell.nam" w]

$ns trace-all $nr
$ns namtrace-all $nf

# Configure flow colors
$ns color 2 Red
$ns color 3 Blue
$ns color 4 Green
$ns color 5 Black
$ns color 6 Violet

# Finish procedure
proc finish {} {
    global ns nr nf

    $ns flush-trace
    close $nr
    close $nf

    # Open NAM visualization
    exec nam dumbell.nam &
    exit 0
}

# ------------------------------------------------------------
# Create nodes
# Left-side source nodes: n0-n4
# Router nodes: n5-n9
# Right-side destination node: n10
# ------------------------------------------------------------

for {set i 0} {$i <= 10} {incr i} {
    set n($i) [$ns node]
}

# ------------------------------------------------------------
# Create access links from sources to routers
# ------------------------------------------------------------

for {set i 0} {$i < 5} {incr i} {
    set j [expr {$i + 5}]
    $ns duplex-link $n($i) $n($j) 5Mb 20ms DropTail
    $ns duplex-link-op $n($i) $n($j) orient down
}

# ------------------------------------------------------------
# Create the bottleneck chain between routers
# ------------------------------------------------------------

for {set i 5} {$i < 10} {incr i} {
    set j [expr {$i + 1}]
    $ns duplex-link $n($i) $n($j) 0.5Mb 100ms DropTail
    $ns duplex-link-op $n($i) $n($j) orient right
}

# ------------------------------------------------------------
# Configure five TCP/FTP flows to destination n10
# ------------------------------------------------------------

for {set i 0} {$i < 5} {incr i} {
    set tcp($i) [new Agent/TCP]
    $ns attach-agent $n($i) $tcp($i)

    set ftp($i) [new Application/FTP]
    $ftp($i) set packetSize_ 500
    $ftp($i) set interval_ 0.005
    $ftp($i) attach-agent $tcp($i)

    set sink($i) [new Agent/TCPSink]
    $ns attach-agent $n(10) $sink($i)

    $ns connect $tcp($i) $sink($i)

    # Flow IDs and colors
    set fid [expr {$i + 2}]
    $tcp($i) set fid_ $fid
}

# ------------------------------------------------------------
# Schedule FTP traffic
# ------------------------------------------------------------

for {set i 0} {$i < 5} {incr i} {
    $ns at 0.2 "$ftp($i) start"
    $ns at 4.5 "$ftp($i) stop"
}

# Stop simulation at 5 seconds
$ns at 5.0 "finish"

# Run simulation
$ns run

