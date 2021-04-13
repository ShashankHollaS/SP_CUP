load("dataset2.mat")
getNoise
userNo = 40;
sumReceivedSignal = sum(receivedSignal(:, :, userNo), 2); % summation Zi
noise = zeros(500, 1);
% summation noise
for i=1:4096
    noise = noise + (sqrt(variance)) * randn(500, 1);
end

hd_plus_vi1 = ((sumReceivedSignal-noise)) ./ transmitSignal; % eqn (3)
hd_plus_vi1 = hd_plus_vi1/4096;

noise = (sqrt(variance)) * randn(500, 4096);
tmp = ((receivedSignal(:, :, userNo) - noise)) ./ transmitSignal;
channel = (tmp - hd_plus_vi1)/(pilotMatrix); % eqn (4)
disp("Channel estimated for user " + num2str(userNo))