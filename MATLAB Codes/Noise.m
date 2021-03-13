% Code to Calculate the Mean and Standard Deviation of Noise from the
% Original Dataset.

tic
Pairs2
clear i;
clear j;

net_noise = reshape(noise, [], 1);

pd_real = fitdist(real(net_noise),'Normal');
pd_imag = fitdist(imag(net_noise),'Normal');

mean = pd_real.mu + j * pd_imag.mu;
sigma = pd_real.sigma + j * pd_imag.sigma;

%{
% Check up

noise_check = [];

for x = 1 : 1000
    noise_check(x, :) = (sigma) * randn(1,500) + mean;
end

noise = reshape(noise, [], 1);

h = histfit(real(net_noise))
hold on
h = histfit(real(noise_check))
%}

noise = (sigma/2) * randn(1,500) + mean;

toc