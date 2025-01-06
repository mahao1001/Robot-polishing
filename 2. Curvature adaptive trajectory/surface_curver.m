close all;
clear;clc

%% 示例数据（自由曲线坐标）
% x = [1, 2, 3, 4, 5, 6, 7 ,8 ,9 ,10];
% y = [1, 1, 1, 1, 1, 80, 3, 0, -5, -2];

%% Surface生成了曲面网格，再处理。导入数据，逐行的计算
% load("wpts_X.mat");
% load("wpts_Y.mat");
% load("wpts_Z.mat");

[X,Y] = meshgrid(1:7:99);
Z =0.2*Y.*sin(X/20) -0.2* X.*cos(Y/20);

P = [X(:), Y(:), Z(:)];
size = length(X);
% 绘制三维曲线
figure;
for i=1:size
    s = (i-1)*size+1;
    e = i*size;
    plot3(P(s:e,1), P(s:e,2), P(s:e,3), 'LineWidth', 2);
    hold on;
end
grid on;
view(-45, 45);
axis equal; % 设置坐标轴比例一致
% 添加标签和标题
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
% title('三维线');