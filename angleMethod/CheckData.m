% getNoise
% load dataset2.mat
global hd_plus_vi1;
global channel;
userNo = [1, 2, 4, 5, 8, 9, 10, 12, 13, 14, 15, 17, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 29, 31, 36, 37, 39, 41, 42, 43, 44, 46, 47, 48, 49, 50];
for i=1:length(userNo')
[hd_plus_vi1, channel] = findChannel(receivedSignal, transmitSignal, pilotMatrix, userNo(i));

channel_sorted = sort(channel, 2);
angles = angle(channel_sorted);
angles = (angles*180)/pi;

axis1 = zeros(500, 1);
axis2 = zeros(500, 1);

for i = 1:500
    count1=0;
    count2=0;
    count3=0;
    count4=0;
    for j = 1:4096
        if angles(i, j)>=0 && angles(i, j)<90
            count1 = count1+j;
        else if angles(i, j)>=90 && angles(i, j)<180
                count2 = count2+j;
            else if angles(i, j)>=-180 && angles(i, j)<-90
                    count3 = count3+j;
                else
                    count4 = count4+j;
                end
            end
        end
    end
    [ignore, axis1(i, 1)] = max([count1 count3]);
    [ignore, axis2(i, 1)] = max([count2 count4]);
end

[channel_sorted1, indices] = sort(channel, 1);

theta = zeros(4096, 1);
theta(1, 1) = 1;
for j=2:4096
    count1=0;
    count2=0;
    for i=1:500
        ele_angle = (angle(channel(i, j))*180)/pi;
        major_axis1 = axis1(i, 1);
        major_axis2 = axis2(i, 1);
        if ele_angle>=0 && ele_angle<90
            if major_axis1 == 1
                count1 = count1+indices(i, j);
            else
                count2 = count2+indices(i, j);
            end
        else if ele_angle>=90 && ele_angle<180
                if major_axis2 == 1
                    count1 = count1+indices(i, j);
                else
                    count2 = count2+indices(i, j);
                end
            else if ele_angle>=-180 && ele_angle<-90
                    if major_axis1 == 1
                        count2 = count2+indices(i, j);
                    else
                        count1 = count1+indices(i, j);
                    end
                else
                    if major_axis2 == 1
                        count2 = count2+indices(i, j);
                    else
                        count1 = count1+indices(i, j);
                    end
                end
            end
        end
    end
    if count1>count2
        theta(j, 1) = 1;
    else
        theta(j, 1) = -1;
    end
end
get_rate(hd_plus_vi1, channel, theta)
end
% theta = MapVariables(theta);

% lb = ones(4096,1);
% ub = 2*ones(4096,1);
% 
% opts = optimoptions(@ga,'InitialPopulationMatrix', theta','MaxGenerations',100, 'MaxStallGenerations', 100, 'PopulationSize', 200, 'CrossoverFraction', 0.8, 'PlotFcn', @gaplotbestf);
% [theta_val, fval, exitflag, output, final_val] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts);
% 
% opts1 = optimoptions(@ga,'InitialPopulationMatrix', final_val, 'MaxGenerations',60, 'MaxStallGenerations', 60, 'PopulationSize', 300, 'PlotFcn', @gaplotbestf);
% [theta_val1, fval1, exitflag1, output1, final_val1] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts1);
% 
% opts2 = optimoptions(@ga,'InitialPopulationMatrix', final_val1, 'MaxGenerations',30, 'MaxStallGenerations', 30, 'PopulationSize', 400,'PlotFcn', @gaplotbestf);
% [theta_val2, fval2, exitflag2, output2, final_val2] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts2);
%   
% function y = rate(theta_tmp)
% theta_tmp = MapVariables(theta_tmp);
% global variance;
% N0 = abs(variance);
% P = 1;
% B = power(10,7);
% y = 0;
% K = 500;
% M = 20;
% global hd_plus_vi1;
% global channel;
% 
% for i = 1:500
%         h = hd_plus_vi1(i) + channel(i,2:4096)*(theta_tmp(2:4096)');
%         y = y - (B/(K+M-1))*log2(1 + (P*(abs(h)^2)) / (B*N0));
% end
% end