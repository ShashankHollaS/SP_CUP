load("dataset2.mat")
getNoise
global sigma;
sumReceivedSignal = sum(receivedSignal(:, :, 40), 2); % summation Zi
noise = zeros(500, 1);
% summation noise
for i=1:4096
    noise = noise + (sqrt(sigma)/sqrt(2)) * randn(500, 1);
end
%F = DFT(K);
global hd_plus_vi1;
global channel;
hd_plus_vi1 = ((sumReceivedSignal-noise)) ./ transmitSignal; % eqn (3)
hd_plus_vi1 = hd_plus_vi1/4096;

noise = (sqrt(sigma)/sqrt(2)) * randn(500, 4096);
tmp = ((receivedSignal(:, :, 40) - noise)) ./ transmitSignal;
%tmp1 = zeros(500, 4096);
%tmp1(:, 1) = hd_plus_vi1;
channel = (tmp - hd_plus_vi1)/(pilotMatrix); % eqn (4)
disp("Channel estimated");
