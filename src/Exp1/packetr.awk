BEGIN{
    rec=1;
    send=1;
    rate=0;
}

{
    if ($1 == "+" && $5 == "tcp" && $3 == "0") {
        send = send + $6;
    }

    if ($1 == "r" && $5 == "tcp" && $4 == "3") {
        rec = rec + $6;
    }
}

END{
    rate = (rec/send) * 100;

    printf("Packet Send = %d\n", send);
    printf("Packet Received = %d\n", rec);
    printf("Bandwidth = %.1f Mb\n", bw);
    printf("Packet Delivery Ratio = %.2f%%\n", rate);

    printf("%.1f %.2f\n", bw, rate) >> "result1.log";
}
