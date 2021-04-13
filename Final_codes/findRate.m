getChannelcorrect

B = power(10,7);
M = 20;
N0 = abs(sigma)/2;
P = 1;
K = 500;
R = zeros(4096,1);
for j = 1:4096
    for i = 1:500
        h = hd_plus_vi1(i) + channel(i,:)*pilotMatrix(:,j);
        R(j) = R(j) + (B/(K+M-1)) * log2(1 + (P*(abs(h)^2)) / (B*N0));
    end
end