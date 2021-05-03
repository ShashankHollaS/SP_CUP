% Change the FOLDER PATH to the Path where this code is Located
% Copy and Paste Dataset 1 and 2 into this directory

getNoise
load dataset2.mat

FOLDER_PATH = 'C:\Users\HP\Downloads\SP Cup\Final_Codes\Karthik\Theta';

Excel_Values = zeros(50, 2);

for user = 1 : 50
    disp(user);
    userNo = user;

    [hd_plus_vi1, channel] = findChannel(receivedSignal, transmitSignal, pilotMatrix, userNo);

    if userNo < 10
        theta = load('theta_' + string(sprintf('%02d',userNo)) + '.mat').theta;
        name = string(sprintf('%02d',userNo));
    else
        theta = load('theta_' + string(userNo) + '.mat').theta;
        name = string(userNo);
    end

    Initial_Rate = get_rate(hd_plus_vi1, channel, theta, variance);
    Initial_Theta = theta;
    Changed_Indices = [];
    Max_Rate = Initial_Rate;

    for i = 1 : length(theta)
        theta1 = theta;
        theta1(i, 1) = flip_element(theta(i, 1));
        r1 = get_rate(hd_plus_vi1, channel, theta, variance);
        r2 = get_rate(hd_plus_vi1, channel, theta1, variance);
        if r2>r1
            Changed_Indices(end+1) = i;
            theta = theta1;
            Max_Rate = r2;
        end 
    end    
    
    fileID = fopen('Results.txt','a');
    fprintf(fileID, 'Initial Rate for config %d : %06f\n', userNo, Initial_Rate);
    fprintf(fileID, 'Final Rate for config %d   : %06f\n', userNo, Max_Rate);
    fclose(fileID);
    
    Excel_Values(user, 1) = Initial_Rate;
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
    
    saveas(gcf, fullfile(FOLDER_PATH , strcat('\Images\' ,name, '.png')));
    
    close;
    
    save(FOLDER_PATH + strcat('\Results\','New_Config_' + name, '.mat'), 'theta');
    
    fprintf("Completed User %d\n", userNo);
end

writematrix(Excel_Values, 'Results.xlsx', 'Sheet', 1); 

fprintf("ALL DONE! \n");

function y = flip_element(x)
    if x==1
        y=-1;
    else
        y=1;
    end
end