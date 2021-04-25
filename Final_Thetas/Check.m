Configs = [2, 4, 10, 12, 13, 14, 18, 20, 21, 23, 24, 25, 26, 28, 39, 44, 46, 47, 48, 49, 50];

av1 = load('All_Values_1-20.mat');
av2 = load('All_Values_11-20.mat');
av3 = load('All_Values_21-30.mat');
av4 = load('All_Values_31-35.mat');
av5 = load('All_Values_36-40.mat');
av6 = load('All_Values_41-50.mat');

Final_All_Values = av1.All_Values;
for x = 11 : 20
    Final_All_Values{end+1} = av2.All_Values{x};
end
for x = 21 : 30
    Final_All_Values{end+1} = av3.All_Values{x};
end
for x = 31 : 35
    Final_All_Values{end+1} = av4.All_Values{x};
end
for x = 36 : 40
    Final_All_Values{end+1} = av5.All_Values{x};
end
for x = 41 : 50
    Final_All_Values{end+1} = av6.All_Values{x};
end

Final_Thetas = zeros(4096, 50);

for y = 1 : 50
    if sum(ismember(Configs, y))
        theta = Final_All_Values{y}{4};
        transformed = MapVariables(theta);
        Final_Thetas(:, y) = transformed;
    end
end