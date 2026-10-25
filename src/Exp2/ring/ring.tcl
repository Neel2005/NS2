
set ns [new Simulator]
set nf [open ring.nam w]
set tf [open ring.tr w]
$ns namtrace-all $nf
$ns trace-all $tf

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Black

for {set i 0} {$i < 8} {incr i} {
    set n($i) [$ns node]
}

for {set i 0} {$i < 8} {incr i} {
    set j [expr {($i + 1) % 8}]
    $ns duplex-link $n($i) $n($j) 2Mb 10ms DropTail
    $ns queue-limit $n($i) $n($j) 10
}

set tcp [new Agent/TCP]
$ns attach-agent $n(0) $tcp
$tcp set fid_ 1

set sink [new Agent/TCPSink]
$ns attach-agent $n(3) $sink
$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 1.0 "$ftp start"
$ns at 4.0 "$ftp stop"

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam ring.nam &
    exit 0
}

$ns at 5.0 "finish"
$ns run

