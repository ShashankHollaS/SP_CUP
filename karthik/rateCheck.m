load dataset1
load dataset2

getNoise

rates = zeros(50, 1);
indices = zeros(50, 1);
for j=1:50
    [hd_plus_vi1, channel] = findChannel(receivedSignal, transmitSignal, pilotMatrix, j);
    init_rates = zeros(4096,1);
    for i=1:4096
        init_rates(i, 1) = get_rate(hd_plus_vi1, channel, pilotMatrix(:, i), variance);
    end

    [max_rate, max_index] = max(init_rates);
    rates(j, 1) = max_rate;
    indices(j, 1) = max_index;
end