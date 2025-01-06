close all
clear;clc


% 加载 .fig 文件
open('16-32.fig'); % 替换为你的文件名
h = findobj(gca, 'Type', 'line');
x = h.XData; % 获取 x 坐标
y = h.YData; % 获取 y 坐标

% 确保 x 和 y 是列向量
if size(x, 1) == 1
    x = x'; % 转置为列向量
end
if size(y, 1) == 1
    y = y'; % 转置为列向量
end

% 初始化存储法向量的变量
n = length(x); % 数据点个数
normals = zeros(n, 2);

% 计算法向量
for i = 2:n-1
    % 利用前后点计算切线向量
    tangent = [x(i+1) - x(i-1), y(i+1) - y(i-1)];
    % 正交化切线向量以获得法向量
    normal = [-tangent(2), tangent(1)];
    % 归一化法向量
    normal = normal / norm(normal);
    normals(i, :) = normal;
end

% 边界点的法向量（使用第一个和最后一个点的切线近似）
tangent_start = [x(2) - x(1), y(2) - y(1)];
normal_start = [-tangent_start(2), tangent_start(1)];
normals(1, :) = normal_start / norm(normal_start);

tangent_end = [x(n) - x(n-1), y(n) - y(n-1)];
normal_end = [-tangent_end(2), tangent_end(1)];
normals(n, :) = normal_end / norm(normal_end);

% 绘制曲线及其法向量
figure;
plot(x, y, '-o'); hold on;
quiver(x, y, normals(:, 1), normals(:, 2), 0.5, 'r'); % 绘制法向量
title('法向量可视化');
xlabel('X');
ylabel('Y');
axis equal;


%% 计算与竖直方向的夹角
% 竖直方向单位向量
vertical_vector = [0, 1];

% 初始化存储角度的变量
angles = zeros(n, 1);

% 计算每个点的法向量与竖直方向的夹角
for i = 1:n
    % 法向量
    normal = normals(i, :);
    % 点积计算夹角的余弦值
    cos_theta = dot(normal, vertical_vector) / (norm(normal) * norm(vertical_vector));
    % 通过反余弦函数得到角度（弧度）
    theta = acos(cos_theta);
    % 转换为角度制
    angles(i) = rad2deg(theta);
    
    % 检查法向量方向（法向量在竖直方向左侧时，角度为负）
    if normal(1) < 0
        angles(i) = -angles(i);
    end
end

% 显示结果
disp('每个点的法向量与竖直方向的夹角 (单位: 度):');
disp(angles);

% 可视化角度信息（可选）
figure;
plot(1:n, angles, '-o');
title('法向量与竖直方向夹角');
xlabel('点索引');
ylabel('夹角 (度)');
grid on;


%% 自由计算
angles_surface = 180-angles

T = [x,y,angles_surface]