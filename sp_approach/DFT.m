function F = DFT(K)
    F = zeros(K);
    for k=1:K
        for m=1:K
            F(k, m) = exp(-1j*2*pi*(k-1)*(m-1)/K);
        end
    end
end