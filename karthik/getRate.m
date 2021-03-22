getNoise

% generate noise with parameters obtained from getNoise
% mean is zero as noise is circularly symmetric
noise = (sigma/sqrt(2)) * randn(500, 16384);
B = 10 * 10^6;
K = 500;
M = 20;
P = 1;
x = zeros(500,16384);
for i = 1 : 16384
    x(:,i) = x(:,i) + transmitSignal;
end

% receivedSignal = hx + noise
h = (receivedSignal4N - noise)./ x;
hv = zeros(1,16384);

% find magnitude of h and sum them across all subcarriers
for i = 1 : 16384
    hv(1,i) = sum(abs(h(:,i))); 
end

% find rate according to equation given in description.pdf
r = (B/(K+M-1))*log2(1+(P*(hv.^2))/(B*(sigma*sigma/2)));