load Best_rates
load Best_indices
load dataset2

% User Number ; Best {GA1 (2), GA2 (2)} ; Random {GA1 (2), GA2 (2), GA3 (2)}
All_Values = {};

lb = ones(4096,1);
ub = 2*ones(4096,1);

for u = 26 : 26 % Change this for Users ( 1 : 50)
    
    disp("Best Configuration for User " + num2str(u));
    
    All_Values{u} = {u};
    disp("Appended User " +num2str(u));
    
    getChannelcorrect(u)
    
    theta_in = MapVariables_rev(pilotMatrix(:,indices(u)))';
    
    opts = optimoptions(@ga,'InitialPopulationMatrix',theta_in,'MaxGenerations',100, 'MaxStallGenerations', 100, 'PopulationSize', 200,  'PlotFcn', @gaplotbestf);
    [theta_val, fval, exitflag, output, final_val] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts);
    
    All_Values{u}{end+1} = theta_val;
    All_Values{u}{end+1} = fval;
    
    opts2 = optimoptions(@ga,'InitialPopulationMatrix', final_val, 'MaxGenerations',30, 'MaxStallGenerations', 30, 'PopulationSize', 400,'PlotFcn', @gaplotbestf);
    [theta_val2, fval2, exitflag2, output2, final_val2] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts2);
    
    All_Values{u}{end+1} = theta_val2;
    All_Values{u}{end+1} = fval2;
    
%     disp("Random Configuration for User " + num2str(u));
%     
%     theta_in = rand(1,4096);
%     for j = 1:4096
%        if theta_in(j) < 0.5
%            theta_in(j) = 1;
%        else
%           theta_in(j) = 2; 
%        end    
%     end
%     
%     opts = optimoptions(@ga,'InitialPopulationMatrix',theta_in,'MaxGenerations',100, 'MaxStallGenerations', 100, 'PopulationSize', 200,  'PlotFcn', @gaplotbestf);
%     [theta_val3, fval3, exitflag3, output3, final_val3] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts);
%     
%     All_Values{u}{end+1} = theta_val3;
%     All_Values{u}{end+1} = fval3;
%         
%     opts1 = optimoptions(@ga,'InitialPopulationMatrix', final_val3, 'MaxGenerations',60, 'MaxStallGenerations', 60, 'PopulationSize', 300, 'PlotFcn', @gaplotbestf);
%     [theta_val4, fval4, exitflag4, output4, final_val4] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts1);
% 
%     All_Values{u}{end+1} = theta_val4;
%     All_Values{u}{end+1} = fval4;
%     
%     opts2 = optimoptions(@ga,'InitialPopulationMatrix', final_val4, 'MaxGenerations',30, 'MaxStallGenerations', 30, 'PopulationSize', 400,'PlotFcn', @gaplotbestf);
%     [theta_val5, fval5, exitflag5, output5, final_val5] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts2);
%     
%     All_Values{u}{end+1} = theta_val5;
%     All_Values{u}{end+1} = fval5;
end
  
function y = rate(theta_tmp)
theta_tmp = MapVariables(theta_tmp);
global variance;
N0 = abs(variance);
P = 1;
B = power(10,7);
y = 0;
K = 500;
M = 20;
global hd_plus_vi1;
global channel;

for i = 1:500
        h = hd_plus_vi1(i) + channel(i,2:4096)*(theta_tmp(2:4096)');
        y = y - (B/(K+M-1))*log2(1 + (P*(abs(h)^2)) / (B*N0));
        
end
end



