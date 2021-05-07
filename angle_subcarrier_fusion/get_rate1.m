function y = get_rate1(hd_plus_vi1, channel, theta)
    h = hd_plus_vi1 + channel(:, 2:4096)*theta(2:4096);
    y = sum(abs(h)*10e6);
end

