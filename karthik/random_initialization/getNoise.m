load("dataset1.mat")
s = size(pilotMatrix4N);

% find same pairs and get noise_difference signal
findPairs

% reshape noise_difference signal
net_noise = reshape(noise, [], 1);

% fit normal distributions to the real and imaginary parts of
% noise_difference separately
pd_real = fitdist(real(net_noise),'Normal');
pd_imag = fitdist(imag(net_noise),'Normal');

% this is the estimated mean and standard deviation of the noise added to the dataset
global avg;
global stddev;
global variance;
avg = pd_real.mu + 1j * pd_imag.mu;
stddev = pd_real.sigma + 1j * pd_imag.sigma;
variance = (abs(stddev).^2)/2;