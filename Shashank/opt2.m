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

insulationFactor = 1;

opts = optimoptions(@simulannealbnd, "PlotFcn",@saplotbestf);
[theta, fval] = simulannealbnd(@rate,theta_in,lb,ub,opts);
 


function y = rate(theta_tmp)
theta_tmp = MapVariables(theta_tmp);
global sigma;
N0 = abs(sigma)/2;
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