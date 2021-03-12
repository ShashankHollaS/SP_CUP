load("dataset1.mat")
s = size(pilotMatrix4N);
negativePairs = zeros(s(2)/2, 2);
for i=1:s(2)/2
    for j=s(2)/2+1:s(2)
        t=1;
        for k=1:N
            if pilotMatrix4N(k, i) ~= -pilotMatrix4N(k, j)
                t = 0;
                break
            end
        end
        if t==1
            negativePairs(i, 1) = i;
            negativePairs(i, 2) = j;
            break;
        end
    end
end