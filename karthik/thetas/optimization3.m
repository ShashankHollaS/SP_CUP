getNoise

load D:\sixth-sem\sp_cup_2021\dataset2.mat % change path accordingly

users = [1, 5, 6, 7, 9, 11, 15, 16, 17, 19, 22, 27, 29, 30, 31, 32, 33, 35, 36, 37, 38, 40, 41, 42, 43, 45];

for i=9:17
    filename = "user" + num2str(users(i)) + "_thetas.mat";
    load(filename);
    theta_in = thetas(:, 3);
    lb = ones(4096,1);
    ub = 2*ones(4096,1);
    global hd_plus_vi1;
    global channel;
    [hd_plus_vi1, channel] = findChannel(receivedSignal, transmitSignal, pilotMatrix, users(i));
    
    opts = optimoptions(@ga,'InitialPopulationMatrix', theta_in','MaxGenerations',60, 'MaxStallGenerations', 100, 'PopulationSize', 200, 'CrossoverFraction', 0.8, 'PlotFcn', @gaplotbestf);
    [theta_val, fval, exitflag, output, final_val] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts);

    opts1 = optimoptions(@ga,'InitialPopulationMatrix', final_val, 'MaxGenerations',60, 'MaxStallGenerations', 60, 'PopulationSize', 300, 'PlotFcn', @gaplotbestf);
    [theta_val1, fval1, exitflag1, output1, final_val1] = ga(@rate, 4096, [], [], [], [], lb, ub, [], 1:4096, opts1);

    new_thetas = [theta_val' theta_val1'];
    new_fvals = [fval fval1];

    save(filename + "_new_thetas.mat", 'new_thetas');
    save(filename + "_new_fvals.mat", 'new_fvals');
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