close all;clear;clc
% 按照输入输出得到响应面模型 mahao1001@outlook.com 
%%
% 1. 导入数据 (假设数据在一个 Excel 文件中)
data = readtable('robot_polishing24.xlsx'); % 确保文件名正确并在工作路径中

% 2. 提取相关列
x1 = data.Feature3; % 特征1
x2 = data.Feature4; % 特征2
y = data.Output;    % 输出


% 3. 创建网格
x1_range = linspace(min(x1), max(x1), 100); % 特征1范围
x2_range = linspace(min(x2), max(x2), 100); % 特征2范围
[X1, X2] = meshgrid(x1_range, x2_range);    % 创建网格

% 4. 插值计算响应值
Y = griddata(x1, x2, y, X1, X2, 'cubic'); % 'cubic' 插值

% 5. 绘制响应面图
figure;
surf(X1, X2, Y, 'EdgeColor', 'none'); % 响应面
colormap('jet'); % 使用 'jet' 映射
colorbar; % 显示颜色条
xlabel('vf (mm/min)');
ylabel('Tp (No.)');
zlabel('Roughness (μm)');
title('vf and Tp Response Surface for Roughness');
grid on;

% 旋转角度 水平旋转45°，垂直旋转0°
view(45, 45);


% % 动态旋转
% for az = 0:5:360
%     view(az, 45); % 水平旋转 (azimuth) 从0到360度，垂直角度固定为30°
%     pause(0.1); % 每次旋转暂停0.1秒
% end

% 6. 如果需要等高线图
figure;
contourf(X1, X2, Y, 20, 'LineColor', 'none'); % 等高线图
colormap('jet'); % 使用 'jet' 映射
colorbar;
xlabel('vf (mm/min)');
ylabel('Tp (No.)');
title('Contour Plot of vf and Tp');
grid on;
