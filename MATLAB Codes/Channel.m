load('dataset1.mat')
sz = size(receivedSignal4N);
out = zeros(size(receivedSignal4N(1,:)));
for i  = 1 : sz(1)
    out = out + angle(receivedSignal4N(i, :));
    %pause(0.5);
end