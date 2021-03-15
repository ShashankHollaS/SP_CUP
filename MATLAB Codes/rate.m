pairs2
B = 10 * 10^6;
K = 500;
M = 20;
P = 1;
noise_vec = sqrt(N0/2) * randn(500,16384);
x = zeros(500,16384);
for i = 1 : 16384
    x(:,i) = x(:,i) + transmitSignal;
end
h = (receivedSignal4N - noise_vec)./ x;
hv = zeros(1,16384);
for i = 1 : 16384
    hv(1,i) = abs(sum(h(:,i))); 
end
r = (B/(K+M-1))*log2(1+(P*(hv.^2))/(B*N0));
