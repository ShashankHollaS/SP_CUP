% Change the FOLDER PATH to the Path where this code is Located
% Copy and Paste Dataset 1 and 2 into this directory

% Created Files and Folders :
%   1. SC + Apriori Images
%   2. SC + Apriori Results
%   3. SC Results
%   4. SC_Ap_Results.txt
%   5. SC_AP_Results.xlsx

getNoise
load dataset2.mat

FOLDER_PATH = 'C:\Users\HP\Downloads\SP Cup\Final_Codes\Karthik\Theta';

Excel_Values = zeros(50, 2);
% First is Only SC, Second is SC + Apriori

max_iter_per_loop = 512;

for user = 1 : 50
    disp(user);
    userNo = user;

    [hd_plus_vi1, channel] = findChannel(receivedSignal, transmitSignal, pilotMatrix, userNo);

    subcarrier_powers = zeros(500, 1);
    
    if userNo < 10
        name = string(sprintf('%02d',userNo));
    else
        name = string(userNo);
    end
    
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
                    r1 = get_rate(hd_plus_vi1, channel, theta, variance);
                    r2 = get_rate(hd_plus_vi1, channel, theta1, variance);
                    if r1<r2
                        theta(col(j), 1) = curr_theta(col(j), 1);
                        switched = switched+1;
                    end
                end
            end
        end
        disp(i);
        disp(get_rate(hd_plus_vi1, channel, theta, variance));
    end

    save(FOLDER_PATH + strcat('\SC Results\','sc_theta_' + name + '.mat'), 'theta');    
    Excel_Values(user, 1) = get_rate(hd_plus_vi1, channel, theta, variance);
    
    % Apriori Starts Here
    
    Initial_Rate = get_rate(hd_plus_vi1, channel, theta, variance);
    Initial_Theta = theta;
    Max_Rate = Initial_Rate;

    for i = 1 : length(theta)
        theta1 = theta;
        theta1(i, 1) = flip_element(theta(i, 1));
        r1 = get_rate(hd_plus_vi1, channel, theta, variance);
        r2 = get_rate(hd_plus_vi1, channel, theta1, variance);
        if r2>r1
            theta = theta1;
            Max_Rate = r2;
        end 
    end
    
    fileID = fopen('SC_Ap_Results.txt','a');
    fprintf(fileID, 'Initial Rate for config %d : %06f\n', userNo, Initial_Rate);
    fprintf(fileID, 'Final Rate for config %d   : %06f\n', userNo, Max_Rate);
    fclose(fileID);
    
    Excel_Values(user, 2) = Max_Rate;

    figure;
    
    subplot(1,3,1)
    pcolor(reshape(Initial_Theta, 64, 64));
    colorbar;

    subplot(1,3,2)
    pcolor(reshape(theta, 64, 64));
    colorbar;

    subplot(1,3,3)
    pcolor(reshape(Initial_Theta - theta, 64, 64));
    colorbar;
    
    saveas(gcf, fullfile(FOLDER_PATH , strcat('\SC + Apriori Images\' ,name, '.png')));
    
    close;
    
    save(FOLDER_PATH + strcat('\SC + Apriori Results\','sc_ap_theta_' + name, '.mat'), 'theta');
    
    fprintf("Completed User %d\n", userNo);
end

writematrix(Excel_Values, 'SC_AP_Results.xlsx', 'Sheet', 1); 

fprintf("ALL DONE! \n");

function y = flip_element(x)
    if x==1
        y=-1;
    else
        y=1;
    end
end