load('dataset1.mat')
sz = size(receivedSignal4N);
for i  = 1 : 50%sz(2)
    figure
    plot(angle(receivedSignal4N(:, i)) - angle(transmitSignal))
    pause(0.5);
end