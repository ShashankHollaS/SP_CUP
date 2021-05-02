getNoise
load dataset2.mat

userNo = 6;
max_iter_per_loop = 80; % increasing this value slows down the algorithm

[hd_plus_vi1, channel] = findChannel(receivedSignal, transmitSignal, pilotMatrix, userNo);

subcarrier_powers = zeros(500, 1);

for i=1:500
    for j=1:4096
        subcarrier_powers(i, 1) = subcarrier_powers(i, 1) + abs(channel(i, j))*abs(channel(i, j));
    end
end

[~, indices] = sort(subcarrier_powers, 'descend');

theta = zeros(4096, 1);
curr_theta = zeros(4096, 1);
switched=0;
for i=1:500
    index = indices(i, 1);
    if i==1
        for j=1:4096
            ele_angle = (angle(channel(index, j))*180)/pi;
            if ele_angle>=0 && ele_angle<180
                theta(j, 1) = 1;
            else
                theta(j, 1) = -1;
            end
        end
    else
        for j=1:4096
            ele_angle = (angle(channel(index, j))*180)/pi;
            if ele_angle>=0 && ele_angle<180
                curr_theta(j, 1) = 1;
            else
                curr_theta(j, 1) = -1;
            end
        end
        [~, col] = sort(channel(index, :), 'descend');
        for j=1:max_iter_per_loop
            if curr_theta(col(j), 1)==theta(col(j), 1)
                continue;
            else
                theta1 = theta;
                theta1(col(j), 1) = flip_element(theta(col(j), 1));
                r1 = get_rate(hd_plus_vi1, channel, theta);
                r2 = get_rate(hd_plus_vi1, channel, theta1);
                if r1<r2
                    theta(col(j), 1) = curr_theta(col(j), 1);
                    switched = switched+1;
                end
            end
        end
    end
%     r1 = get_rate(hd_plus_vi1, channel, theta);
%     r2 = get_rate(hd_plus_vi1, channel, curr_theta);
%     if r1<r2
%         theta = curr_theta;
%     end
    disp(i);
    disp(get_rate(hd_plus_vi1, channel, theta));
end

function y = flip_element(x)
    if x==1
        y=-1;
    else
        y=1;
    end
end