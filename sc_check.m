getNoise
load dataset2.mat
getChannelcorrect(1)
global hd_plus_vi1;
global channel;
subcarrier_powers = zeros(500, 1);
for i=1:500
    for j=1:4096
            subcarrier_powers(i, 1) = subcarrier_powers(i, 1) + abs(channel(i, j))*abs(channel(i, j));
    end
end
    
[~, indices] = sort(subcarrier_powers, 'descend');
[~, col] = sort(channel(indices(1), :), 'descend');

