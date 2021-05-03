function rate = get_rate(hd_plus_vi1, channel, config, sigma)
    B = power(10,7);
    N0 = abs(sigma);
    P = 1;
    rate=0;
    K=500;
    M=20;
    for i=1:500
        h = hd_plus_vi1(i) + channel(i, 2:4096)*config(2:4096);
        rate = rate + (B/(K+M-1))*log2(1 + (P*(abs(h)^2))/(B*N0));
    end
end
