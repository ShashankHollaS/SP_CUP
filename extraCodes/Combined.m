load('dataset1.mat')
sz = size(receivedSignal4N);
figure
for i  = 1 : 20%sz(2)
    subplot(1,2,1);
    plot(angle(receivedSignal4N(:, i)) - angle(transmitSignal));
    subplot(1,2,2);
    pcolor(reshape(pilotMatrix4N(:, i), 64, 64));
    pause(1);
end