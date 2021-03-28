%load("dataset2.mat")
getNoise
sumReceivedSignal = sum(receivedSignal(:, :, 1), 2); % summation Zi
noise = zeros(500, 1);
% summation noise
for i=1:4096
    noise = noise + (sigma/sqrt(2)) * randn(500, 1);
end
F = DFT(K);
hd_plus_vi1 = (F\sumReceivedSignal-noise) ./ transmitSignal; % eqn (3)

noise = (sigma/sqrt(2)) * randn(500, 4096);
tmp = (F\(receivedSignal(:, :, 1) - noise)) ./ transmitSignal;
channel = (tmp - hd_plus_vi1)/(pilotMatrix); % eqn (4)