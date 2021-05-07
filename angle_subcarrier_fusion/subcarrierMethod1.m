getNoise
load dataset2.mat

max_iter_per_loop = 200;   
syms r1 r2;

for userNo = 1:50
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
            [theta, ~] = CheckData2(receivedSignal, transmitSignal, pilotMatrix, userNo);
        else
            for j=1:4096
                ele_angle = (angle(channel(index, j))*180)/pi;
                if ele_angle>=0 && ele_angle<180
                    curr_theta(j, 1) = 1;
                else
                    curr_theta(j, 1) = -1;
                end
            end
            for j=1:max_iter_per_loop
                ran = randi([1, 4096], 1);
                if curr_theta(ran, 1)==theta(ran, 1)
                    continue;
                else
                    theta1 = theta;
                    theta1(ran, 1) = flip_element(theta(ran, 1));
                    x = get_rate1(hd_plus_vi1, channel, theta);
                    r1 = vpa(x, 20);
                    y = get_rate1(hd_plus_vi1, channel, theta1);
                    r2 = vpa(y, 20);
                    if r1<r2
                        theta(ran, 1) = curr_theta(ran, 1);
                        switched = switched+1;
                    end
                end
            end
        end
        disp(i);
        disp(get_rate(hd_plus_vi1, channel, theta));
    end
    save("new_theta_" + num2str(userNo) + ".mat", 'theta');
end

function y = flip_element(x)
    if x==1
        y=-1;
    else
        y=1;
    end
end