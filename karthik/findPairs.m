%load("dataset1.mat")
s = size(pilotMatrix4N);
samePairs = zeros(s(2)/2, 2);
noise = zeros(K, s(2)/2);

% Find pairs (i, j) such that pilotMatrix config(i)=pilotMatrix config(j)
% After finding such pairs, get difference between receivedSignal(j) and receivedSignal(i)  
for i=1:s(2)/2
    for j=s(2)/2+1:s(2)
        t=1;
        for k=1:N
            if pilotMatrix4N(k, i) ~= pilotMatrix4N(k, j)
                t = 0;
                break
            end
        end
        if t==1
            samePairs(i, 1) = i;
            samePairs(i, 2) = j;
            noise(:, i) = receivedSignal4N(:, i) - receivedSignal4N(:, j);
            break;
        end
    end
end