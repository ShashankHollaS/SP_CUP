function getChannelcorrect(u)
load("dataset2.mat")
getNoise

global variance;
%sigma = 3.0319e-20;
global mean_val;
sumReceivedSignal = sum(receivedSignal(:, :, u), 2); % summation Zi
noise = zeros(500, 1);

% summation noise
for i=1:4096
    no = sqrt(variance)*randn(500,1);
    no = no - mean(no);
    noise = noise + mean_val + no;
end
%F = DFT(K);
global hd_plus_vi1;
hd_plus_vi1 = ((sumReceivedSignal-noise)) ./ transmitSignal; % eqn (3)
hd_plus_vi1 = hd_plus_vi1/4096;

noise = mean_val + (sqrt(variance)) * randn(500, 4096);
tmp = ((receivedSignal(:, :, u) - noise)) ./ transmitSignal;
%tmp1 = zeros(500, 4096);
%tmp1(:, 1) = hd_plus_vi1;
global channel;
channel = (tmp - hd_plus_vi1)/(pilotMatrix); % eqn (4)
disp("Channel Estimated for " +num2str(u));
