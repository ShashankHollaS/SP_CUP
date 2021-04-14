getChannelcorrect

lb = ones(4096,1);
ub = 2*ones(4096,1);
theta_in = rand(1,4096);
for j = 1:4096
   if theta_in(j) < 0.5
       theta_in(j) = -1;
   else
      theta_in(j) = 1; 
   end
    
end
opts = optimoptions(@ga,'InitialPopulationMatrix',theta_in,'MaxGenerations',100, 'MaxStallGenerations', 100, 'PopulationSize', 200, 'CrossoverFraction', 0.8, 'PlotFcn', @gaplotbestf);
[theta_val, fval, exitflag, output, final_val] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts);

opts1 = optimoptions(@ga,'InitialPopulationMatrix', final_val, 'MaxGenerations',60, 'MaxStallGenerations', 60, 'PopulationSize', 300, 'PlotFcn', @gaplotbestf);
[theta_val1, fval1, exitflag1, output1, final_val1] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts1);

opts2 = optimoptions(@ga,'InitialPopulationMatrix', final_val1, 'MaxGenerations',30, 'MaxStallGenerations', 30, 'PopulationSize', 400,'PlotFcn', @gaplotbestf);
[theta_val2, fval2, exitflag2, output2, final_val2] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts2);


  
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
        h = hd_plus_vi1(i) + channel(i,:)*(theta_tmp');
        y = y - (B/K+M-1)*log2(1 + (P*(abs(h)^2)) / (B*N0));
        
end
end



