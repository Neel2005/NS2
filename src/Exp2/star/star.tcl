
set ns [new Simulator]
set tf [open star.tr w]
set nf [open star.nam w]
$ns trace-all $tf
$ns namtrace-all $nf

proc finish {} {
    global ns tf nf
    $ns flush-trace
    close $tf
    close $nf
    exec nam star.nam &
    exit 0
}

for {set i 0} {$i < 5} {incr i} {
    set n($i) [$ns node]
}

for {set i 0} {$i < 4} {incr i} {
    $ns duplex-link $n(4) $n($i) 5Mb 20ms DropTail
}

set tcp [new Agent/TCP]
$ns attach-agent $n(1) $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n(0) $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 0.5 "$ftp start"
$ns at 4.5 "$ftp stop"
$ns at 5.0 "finish"

$ns run

