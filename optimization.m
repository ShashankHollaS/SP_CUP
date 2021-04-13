getChannelcorrect

P = 1;
B = power(10,7);
N0 = abs(sigma)/2;

lb = -1 * ones(4096);
ub = ones(4096);
[theta, fval] = ga(@rate, 4096, [], [], [], [], lb, ub, @constraints, 1:4096);

function y = rate(theta)
for i = 1:500
        h = hd_plus_vi1(i) + channel(i,:)*theta;
        y = y + 1 / log2(1 + (P*(abs(h)^2)) / (B*N0));
end
end

