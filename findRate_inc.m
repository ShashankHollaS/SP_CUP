function y = findRate_inc(theta)
global channel;
global hd_plus_vi1;
h = hd_plus_vi1 + channel(:,2:4096)*theta(2:4096);
y = sum(abs(h)*10e6);

