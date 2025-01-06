close all;
clear;clc

%% 示例数据（自由曲线坐标）
% x = [1, 2, 3, 4, 5, 6, 7 ,8 ,9 ,10];
% y = [1, 1, 1, 1, 1, 80, 3, 0, -5, -2];

%% Surface生成了曲面网格，再处理。导入数据，逐行的计算
% load("wpts_X.mat");
% load("wpts_Y.mat");
% load("wpts_Z.mat");

%% 直接绘制一个曲面，下面使用。surf是面  mesh是网格
[X,Y] = meshgrid(1:5:99);
Z =0.2*Y.*sin(X/20) -0.2* X.*cos(Y/20);
mesh(X,Y,Z, 'EdgeColor', 'b', 'FaceAlpha', 0.7,'LineStyle','-','LineWidth',1);
view(-15, 15);
% view(0, 0);
axis equal; % 设置坐标轴比例一致
hold on
%% 开始循环计算。X方向作为循环方向i，逐行计算
% 定义插值点数量
num_points = 30;
% 初始化新的矩阵
new_x = zeros(num_points, num_points);
new_y = zeros(num_points, num_points);
new_z = zeros(num_points, num_points);


for i=1:20
    x = X(i,:);
    z = Z(i,:);
    % 计算曲率
    curvature = computeCurvature(x, z);

    % 多项式插值
degree = 5; % 选择插值多项式的次数
coefficients = polyfit(x, z, degree);

% 构造多项式
syms sym_x;
polynomial = poly2sym(coefficients, sym_x);

% 绘制原始数据和插值多项式曲线
xx = linspace(min(x), max(x), length(x));
zz = polyval(coefficients, xx);

    % 定义累积曲率作为插值参数
    cumulative_curvature = cumsum([0, sqrt(diff(xx).^2 + diff(zz).^2)]);

    % 生成非均匀插值点
    t_interp = linspace(0, cumulative_curvature(end), num_points);

    % 使用非均匀插值
    xi_interp = interp1(cumulative_curvature, xx, t_interp, 'pchip', 'extrap');
    zi_interp = polyval(coefficients, xi_interp);

    new_x(i,:) = xi_interp;
    new_z(i,:) = zi_interp;
end


y = Y(:,1)';
for j=1:num_points      
    z = new_z(1:length(Z),j)';
    % 计算曲率
    curvature = computeCurvature(y, z);

% 多项式插值
degree = 5; % 选择插值多项式的次数
coefficients = polyfit(y, z, degree);

% 构造多项式
syms sym_y;
polynomial = poly2sym(coefficients, sym_y);

% 绘制原始数据和插值多项式曲线
yy = linspace(min(y), max(y), length(y));
zz = polyval(coefficients, yy);


    % 定义累积曲率作为插值参数
    cumulative_curvature = cumsum([0, sqrt(diff(yy).^2 + diff(zz).^2)]);

    % 生成非均匀插值点
    t_interp = linspace(0, cumulative_curvature(end), num_points);

    % 使用非均匀插值
    yj_interp = interp1(cumulative_curvature, yy, t_interp, 'pchip', 'extrap');
    zj_interp = polyval(coefficients, yj_interp);
    new_y(:,j) = yj_interp';
    new_z(:,j) = zj_interp';
   
end
new_x = new_y';      

%% 绘制新曲面
% surf(new_x,new_y,new_z, 'FaceColor','r', 'EdgeColor', 'none', 'FaceAlpha', 0.7); 
mesh(new_x,new_y,new_z,  'EdgeColor', 'r', 'FaceAlpha', 0.9,'LineStyle','-','LineWidth',1);
% view(30, 20);
axis equal; % 设置坐标轴比例一致

% 添加标签和标题
% title('Comparison of Two Surfaces');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');

% 添加图例
legend('Orignal surface', 'Proposed surface');