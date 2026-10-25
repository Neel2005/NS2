BEGIN {
    rec = 0
    send = 0
    send1 = 0
    send2 = 0
    send3 = 0
    send4 = 0
    total_bytes = 0
    tr = 0
}

{
    if ($1 == "+" && $5 == "tcp" && $3 == 0)
        send++

    if ($1 == "+" && $5 == "tcp" && $3 == 1)
        send1++

    if ($1 == "+" && $5 == "tcp" && $3 == 2)
        send2++

    if ($1 == "+" && $5 == "tcp" && $3 == 3)
        send3++

    if ($1 == "+" && $5 == "tcp" && $3 == 4)
        send4++

    s = send + send1 + send2 + send3 + send4

    if ($1 == "r" && $5 == "tcp" && $4 == 10) {
        rec++
        total_bytes += $6
        if ($2 > 0)
            tr = total_bytes * 8 / $2 / 1000000
    }
}

END {
    if (s > 0)
        pr = rec / s
    else
        pr = 0

    printf("Number of packets sent to node 10 = %d\n", s)
    printf("Number of packets received at node 10 = %d\n", rec)
    printf("Packet delivery ratio at node 10 = %f\n", pr)
    printf("Throughput of TCP connection to node 10 = %f Mbps\n", tr)
}
