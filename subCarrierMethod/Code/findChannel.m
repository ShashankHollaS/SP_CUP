function [hd_plus_vi1, channel] = findChannel(receivedSignal, transmitSignal, pilotMatrix, userNo)

global avg;
global variance;
sumReceivedSignal = sum(receivedSignal(:, :, userNo), 2); % summation Zi
noise = zeros(500, 1);
for i=1:4096
    rng(2);
    no = (sqrt(variance)) * randn(500, 1);
    no = no - mean(no);
    noise = noise + no + avg;
end
hd_plus_vi1 = ((sumReceivedSignal-noise)) ./ transmitSignal; % eqn (3)
hd_plus_vi1 = hd_plus_vi1/4096;
rng(2);
noise = (sqrt(variance)) * randn(500, 4096);
tmp = ((receivedSignal(:, :, userNo) - noise)) ./ transmitSignal;
channel = (tmp - hd_plus_vi1)/(pilotMatrix); % eqn (4)
disp("Channel estimated for user " + num2str(userNo));
end
