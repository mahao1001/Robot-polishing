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

wpt = P(211:225,:);

plot3(wpt(:,1),wpt(:,2),wpt(:,3));
