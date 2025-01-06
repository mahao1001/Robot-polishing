clear;clc;

%% 把两个.fig图绘制在一起
% 加载第一个保存的 .fig 文件
fig1 = openfig('initial PID.fig');  

% 加载第二个保存的 .fig 文件
fig2 = openfig('Tuned PID.fig');

% 获取第一个图形对象中的子图对象
ax1 = findobj(fig1, 'type', 'axes');

% 获取第二个图形对象中的子图对象
ax2 = findobj(fig2, 'type', 'axes');

% 创建新的图形窗口
figure;

%% 将子图以分行的形式绘制在新图形窗口中
% subplot(2, 1, 1); % 根据需要设置 subplot 的位置
% copyobj(get(ax1, 'children'), gca);
% % 将第二个子图绘制在新图形窗口中
% subplot(2, 1, 2); % 根据需要设置 subplot 的位置
% copyobj(get(ax2, 'children'), gca);

%% 将子图合并绘制
% 获取新图形窗口的坐标轴
ax = gca;

% 将第一个图形的子图对象复制到新图形窗口中
children1 = get(ax1, 'children'); % 获取第一个图形中的所有子对象
copyobj(children1, ax); % 将第一个图形的子对象复制到新图形窗口中
set(ax.Children(1:numel(children1)), 'Color', 'blue'); % 设置第一个图形的线条颜色为蓝色

% 将第二个图形的子图对象叠加到新图形窗口中
hold on; % 保持图形叠加状态
children2 = get(ax2, 'children'); % 获取第二个图形中的所有子对象
copyobj(children2, ax); % 将第二个图形的子对象叠加到新图形窗口中
set(ax.Children(numel(children1)+1:end), 'Color', 'red'); % 设置第二个图形的线条颜色为红色

% 添加图例
legend('Initial PID', 'Tuned PID');

% 根据需要设置其他图形属性
xlabel('X Axis');
ylabel('Y Axis');
title('Combined Plots');
