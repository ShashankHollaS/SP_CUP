load("dataset1.mat")
s = size(pilotMatrix4N);
pairs = zeros(s(2)/2, 2);
for i=1:8192
    for j=8193:16384
        t=1;
        for k=1:4096
            if pilotMatrix4N(k, i) ~= pilotMatrix4N(k, j)
                t = 0;
                break
            end
        end
        if t==1
            pairs(i, 1) = i;
            pairs(i, 2) = j;
            break;
        end
    end
end