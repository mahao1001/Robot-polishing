
clear;clc
close all;

% 假设你已知的数据
% points是50个点的坐标，normals是50个点的法向量
% points = rand(50, 3);  % 随机生成点的坐标作为示例
% normals = rand(50, 3); % 随机生成法向量作为示例

clear;clc
%% 导入曲面曲线轨迹
num_points = 100;
[X,Y] = meshgrid(1:2:99);
Z =0.2*Y.*sin(X/20) -0.2* X.*cos(Y/20);
P0 = [X(:), Y(:), Z(:)];
size = length(X);
for i=1:size
    s = (i-1)*size+1;
    e = i*size;
    P =  [P0(s:e,1), P0(s:e,2), P0(s:e,3)];
    P1 = [P0(s:e,1)+200, P0(s:e,2)*3, 300+P0(s:e,3)*3];  
end
figure;
plot3(P(:,1),P(:,2),P(:,3),'*-')
hold on;
plot3(P(:,1),P(:,2),P(:,3),'ro')
xlabel('X-axis');
ylabel('Y-axis');
zlabel('X-axis');
legend('Waypoint')
hold off;


%% % 导入法向量
load('normals2500.mat');
normals = zeros(length(X),3);
for i=1:size
    s = (i-1)*size+1;
    e = i*size;
    normals =  [normal(s:e,1), normal(s:e,2), normal(s:e,3)];
end


%% 绘制法向量

points = P;

% 初始化旋转矩阵和欧拉角
rotation_matrices = zeros(3, 3, 50);
rotation_angles = zeros(50, 3);

% 计算每个点的旋转矩阵和欧拉角
for i = 1:49
    % 计算切线向量
    tangent_vector = (points(i+1, :) - points(i, :)) / norm(points(i+1, :) - points(i, :));
    
    % 计算法向量
    normal_vector = normals(i, :);
    
    % 构建旋转矩阵
    rotation_matrix = [tangent_vector', cross(normal_vector, tangent_vector)', normal_vector'];
    
    % 存储旋转矩阵
    rotation_matrices(:, :, i) = rotation_matrix;
    
    % 提取欧拉角（绕 Z、Y、X 轴的旋转角度）
    rotation_angles(i, :) = rotm2eul(rotation_matrix, 'XYZ');
end

% 对最后一个点的处理（假设最后一个点的切线向量和法向量与前一个点相同）
rotation_matrices(:, :, 50) = rotation_matrices(:, :, 49);
rotation_angles(50, :) = rotation_angles(49, :);

% 绘制选择角度随点变化的图像
figure;
subplot(3, 1, 1);
plot(1:50, rad2deg(rotation_angles(:, 1)), '-o');
title('Angle of rotation around the X-axis');
xlabel('Index of point');
ylabel('Degrees');

subplot(3, 1, 2);
plot(1:50, rad2deg(rotation_angles(:, 2)), '-o');
title('Angle of rotation around the Y-axis');
xlabel('Index of point');
ylabel('Degrees');

subplot(3, 1, 3);
plot(1:50, rad2deg(rotation_angles(:, 3)), '-o');
title('Angle of rotation around the Z-axis');
xlabel('Index of point');
ylabel('Degrees');
