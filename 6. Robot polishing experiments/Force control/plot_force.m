close all
clear;clc

%% 绘制第一条  按照提出的算法
% 导入数据
data = readtable('11.xlsx', 'Sheet', 'Force2');

% 提取时间和力值
time = datetime(data.('time'), 'InputFormat', 'eeee, MMMM d, y');
force = data.('force')/100*0.76;

% 绘图
figure('Position', [100, 100, 800, 600]);
plot(time, force,LineWidth=1.5);
xlim([min(time), max(time)]);
xlabel('Time (31-Dec-2024)');
ylabel('Polishing force (N)');
title('Proposed polishing force control (22.5 N)');
grid on;
hold off

%%   绘制第二条 非控制力测量

% 导入数据
data = readtable('22.xlsx', 'Sheet', 'Force2');

% 提取时间和力值
time = datetime(data.('time'), 'InputFormat', 'eeee, MMMM d, y');
force = data.('force')/100*0.76;

% 绘图
figure('Position', [100, 100, 800, 600]);
plot(time, force,LineWidth=1.5);
xlim([min(time), max(time)]);
xlabel('Time (31-Dec-2024)');
ylabel('Polishing force (N)');
title('Orignal polishing force control (22.5 N)');
grid on;
hold off
