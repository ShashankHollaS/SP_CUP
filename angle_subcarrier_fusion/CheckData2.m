function [theta, rate] = CheckData2(receivedSignal, transmitSignal, pilotMatrix, userNo)
global hd_plus_vi1;
global channel;
[hd_plus_vi1, channel] = findChannel(receivedSignal, transmitSignal, pilotMatrix, userNo);

angles = angle(channel);
angles = (angles*180)/pi;

axis1 = ones(500, 1);
axis2 = ones(500, 1);

theta1 = zeros(4096, 1);
theta1(1, 1) = 1;
for j=2:4096
    count1=0;
    count2=0;
    for i=1:500
        ele_angle = (angle(channel(i, j))*180)/pi;
        major_axis1 = axis1(i, 1);
        major_axis2 = axis2(i, 1);
        if ele_angle>=0 && ele_angle<90
            if major_axis1 == 1
                count1 = count1+abs(channel(i, j));
            else
                count2 = count2+abs(channel(i, j));
            end
        else if ele_angle>=90 && ele_angle<180
                if major_axis2 == 1
                    count1 = count1+abs(channel(i, j));
                else
                    count2 = count2+abs(channel(i, j));
                end
            else if ele_angle>=-180 && ele_angle<-90
                    if major_axis1 == 1
                        count2 = count2+abs(channel(i, j));
                    else
                        count1 = count1+abs(channel(i, j));
                    end
                else
                    if major_axis2 == 1
                        count2 = count2+abs(channel(i, j));
                    else
                        count1 = count1+abs(channel(i, j));
                    end
                end
            end
        end
    end
    if count1>count2
        theta1(j, 1) = 1;
    else
        theta1(j, 1) = -1;
    end
end
rate1 = get_rate(hd_plus_vi1, channel, theta1);

axis1 = ones(500, 1)+1;
axis2 = ones(500, 1);

theta2 = zeros(4096, 1);
theta2(1, 1) = 1;
for j=2:4096
    count1=0;
    count2=0;
    for i=1:500
        ele_angle = (angle(channel(i, j))*180)/pi;
        major_axis1 = axis1(i, 1);
        major_axis2 = axis2(i, 1);
        if ele_angle>=0 && ele_angle<90
            if major_axis1 == 1
                count1 = count1+abs(channel(i, j));
            else
                count2 = count2+abs(channel(i, j));
            end
        else if ele_angle>=90 && ele_angle<180
                if major_axis2 == 1
                    count1 = count1+abs(channel(i, j));
                else
                    count2 = count2+abs(channel(i, j));
                end
            else if ele_angle>=-180 && ele_angle<-90
                    if major_axis1 == 1
                        count2 = count2+abs(channel(i, j));
                    else
                        count1 = count1+abs(channel(i, j));
                    end
                else
                    if major_axis2 == 1
                        count2 = count2+abs(channel(i, j));
                    else
                        count1 = count1+abs(channel(i, j));
                    end
                end
            end
        end
    end
    if count1>count2
        theta2(j, 1) = 1;
    else
        theta2(j, 1) = -1;
    end
end
rate2 = get_rate(hd_plus_vi1, channel, theta2);

axis1 = ones(500, 1);
axis2 = ones(500, 1)+1;

theta3 = zeros(4096, 1);
theta3(1, 1) = 1;
for j=2:4096
    count1=0;
    count2=0;
    for i=1:500
        ele_angle = (angle(channel(i, j))*180)/pi;
        major_axis1 = axis1(i, 1);
        major_axis2 = axis2(i, 1);
        if ele_angle>=0 && ele_angle<90
            if major_axis1 == 1
                count1 = count1+abs(channel(i, j));
            else
                count2 = count2+abs(channel(i, j));
            end
        else if ele_angle>=90 && ele_angle<180
                if major_axis2 == 1
                    count1 = count1+abs(channel(i, j));
                else
                    count2 = count2+abs(channel(i, j));
                end
            else if ele_angle>=-180 && ele_angle<-90
                    if major_axis1 == 1
                        count2 = count2+abs(channel(i, j));
                    else
                        count1 = count1+abs(channel(i, j));
                    end
                else
                    if major_axis2 == 1
                        count2 = count2+abs(channel(i, j));
                    else
                        count1 = count1+abs(channel(i, j));
                    end
                end
            end
        end
    end
    if count1>count2
        theta3(j, 1) = 1;
    else
        theta3(j, 1) = -1;
    end
end
rate3 = get_rate(hd_plus_vi1, channel, theta3);

axis1 = ones(500, 1)+1;
axis2 = ones(500, 1)+1;

theta4 = zeros(4096, 1);
theta4(1, 1) = 1;
for j=2:4096
    count1=0;
    count2=0;
    for i=1:500
        ele_angle = (angle(channel(i, j))*180)/pi;
        major_axis1 = axis1(i, 1);
        major_axis2 = axis2(i, 1);
        if ele_angle>=0 && ele_angle<90
            if major_axis1 == 1
                count1 = count1+abs(channel(i, j));
            else
                count2 = count2+abs(channel(i, j));
            end
        else if ele_angle>=90 && ele_angle<180
                if major_axis2 == 1
                    count1 = count1+abs(channel(i, j));
                else
                    count2 = count2+abs(channel(i, j));
                end
            else if ele_angle>=-180 && ele_angle<-90
                    if major_axis1 == 1
                        count2 = count2+abs(channel(i, j));
                    else
                        count1 = count1+abs(channel(i, j));
                    end
                else
                    if major_axis2 == 1
                        count2 = count2+abs(channel(i, j));
                    else
                        count1 = count1+abs(channel(i, j));
                    end
                end
            end
        end
    end
    if count1>count2
        theta4(j, 1) = 1;
    else
        theta4(j, 1) = -1;
    end
end
rate4 = get_rate(hd_plus_vi1, channel, theta4);

[rate, index] = max([rate1 rate2 rate3 rate4]);
thetas = [theta1 theta2 theta3 theta4];
theta = thetas(:, index);
end