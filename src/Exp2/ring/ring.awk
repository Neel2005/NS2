
BEGIN {
    sent = 0
    received = 0
}

{
    if ($1 == "+" && $5 == "tcp" && $3 == 0)
        sent++

    if ($1 == "r" && $5 == "tcp" && $4 == 3)
        received++
}

END {
    success = (sent > 0) ? received * 100 / sent : 0
    printf("Packet Send %d\n", sent)
    printf("Packet Receive %d\n", received)
    printf("Success Rate %f\n", success)
}

