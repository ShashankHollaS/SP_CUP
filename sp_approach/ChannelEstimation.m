%load("dataset1.mat");
s = size(pilotMatrix);
% find column which has all coefficients -1
for i=1:s(2)
    x = sum(pilotMatrix(:, i));
    if(x==-4096)
        disp(['All coefficients -1 at i=' num2str(i)]);
        neg = i;
        break;
    end
end
% find column which has all coefficients +1
for i=1:s(2)
    x = sum(pilotMatrix(:, i));
    if(x==4096)
        disp(['All coefficients +1 at i=' num2str(i)]);
        pos = i;
        break;
    end
end

% Z = F*(h + V*theta)*x + noise
% Let h + V*theta = A
% Z = F*A*x + noise
% Approx A = (inv(F)*Z)/x

F = DFT(K);
X = diag(transmitSignal);

Z = receivedSignal4N;
A = inv(F)*inv(X)*Z;

hd = (A(:, pos) + A(:, neg))/2;