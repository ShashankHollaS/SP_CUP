function theta = MapVariables_rev(theta_tmp)

theta = zeros(4096,1);
for i = 1:4096
    if theta_tmp(i) == -1
        theta(i) = 1;
    else
        theta(i) = 2;
    end

end