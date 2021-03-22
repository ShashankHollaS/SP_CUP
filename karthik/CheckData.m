load("dataset1.mat");
s = size(pilotMatrix4N);
counter=0;
for i=1:s(2)/2
    if(pilotMatrix4N(:, i) ~= pilotMatrix4N(:, i + s(2)/2))
        counter = counter+1;
    end
end
