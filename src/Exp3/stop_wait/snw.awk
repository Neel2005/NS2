
BEGIN {
    rec = 0
    send = 0
    total_bytes = 0
    start_time = 0
    end_time = 0
}

{
    if ($1 == "+" && $5 == "tcp" && $3 == 0) {
        send++
        if (send == 1)
            start_time = $2
    }

    if ($1 == "r" && $5 == "tcp" && $4 == 1) {
        rec++
        total_bytes += $6
        end_time = $2
    }
}

END {
    duration = end_time - start_time
    tr = (duration > 0) ? total_bytes * 8 / duration / 1000000 : 0
    pr = (send > 0) ? rec / send : 0
    dt = total_bytes * 8
    bdp = bw * rtt
    lu = (bdp > 0) ? dt / bdp * 100 : 0

    printf("Number of packets sent from node 0 = %d\n", send)
    printf("Number of packets received at node 1 = %d\n", rec)
    printf("Packet delivery ratio at node 1 is %f\n", pr)
    printf("Throughput of TCP connection to node 1 = %f Mbps\n", tr)
    printf("Bandwidth (BW) of the link = %f bits/s\n", bw)
    printf("Data transmitted in bits = %f\n", dt)
    printf("Round Trip Time (RTT) = %f seconds\n", rtt)
    printf("BDP = %f bits\n", bdp)
    printf("Link Utilization = %f%%\n", lu)
}
