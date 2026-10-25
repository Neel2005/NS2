
BEGIN {
    sent = 0
    received = 0
    bytes = 0
    last_time = 0
}

{
    if ($1 == "+" && $5 == "tcp" && $3 == 1)
        sent++

    if ($1 == "r" && $5 == "tcp" && $4 == 0) {
        received++
        bytes += $6
        last_time = $2
    }
}

END {
    ratio = (sent > 0) ? received / sent : 0
    throughput = (last_time > 0) ? bytes * 8 / last_time / 1000000 : 0
    printf("Number of packets sent to node 0 = %d\n", sent)
    printf("Number of packets received at node 0 = %d\n", received)
    printf("Packet delivery ratio at node 0 is %f\n", ratio)
    printf("Throughput of TCP connection to node 0 = %f\n", throughput)
}

