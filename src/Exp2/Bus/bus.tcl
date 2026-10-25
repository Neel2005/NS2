
set ns [new Simulator]
set tf [open bus.tr w]
set nf [open bus.nam w]
$ns trace-all $tf
$ns namtrace-all $nf

proc finish {} {
    global ns tf nf
    $ns flush-trace
    close $tf
    close $nf
    exec nam bus.nam &
    exit 0
}

for {set i 0} {$i < 5} {incr i} {
    set n($i) [$ns node]
}

for {set i 0} {$i < 4} {incr i} {
    set j [expr {$i + 1}]
    $ns duplex-link $n($i) $n($j) 5Mb 20ms DropTail
    $ns duplex-link-op $n($i) $n($j) orient right
}

set tcp [new Agent/TCP]
$ns attach-agent $n(0) $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n(4) $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 0.5 "$ftp start"
$ns at 4.5 "$ftp stop"
$ns at 5.0 "finish"

$ns run

