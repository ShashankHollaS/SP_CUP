load('dataset1.mat')
sz = size(pilotMatrix4N);
for i  = 20 : 50%sz(2)
    %figure
    pcolor(reshape(pilotMatrix4N(:, i), 64, 64))
    pause(1);
end