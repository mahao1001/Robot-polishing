close all;
clear;clc

% % 示例数据（自由曲线坐标）
% x = [1, 2, 3, 4, 5, 6, 7 ,8 ,9 ,10, 11, 12];
% y = [13.5, 24.8, 35, 41, 39, 22.5, 8, 9, 15, 27.5, 45, 51];

% 导入数据，逐行的计算
load("wpts_X.mat");
load("wpts_Y.mat");
load("wpts_Z.mat");
x = Y(1:2:49,50)'; 
y = Z(1:2:49,50)';

% % 函数的形式
% x = 1:2:99;
% y = sin(x/18);

%%
% 多项式插值
degree = 5; % 选择插值多项式的次数
coefficients = polyfit(x, y, degree);

% 构造多项式
syms sym_x;
polynomial = poly2sym(coefficients, sym_x)

% 绘制原始数据和插值多项式曲线
xx = linspace(min(x), max(x), length(x));
yy = polyval(coefficients, xx);

%%
% 计算曲率
% curvature = computeCurvature(xx, yy);

% 定义累积曲率作为插值参数
cumulative_curvature = cumsum([0, sqrt(diff(xx).^2 + diff(yy).^2)]);

% 定义插值点数量
num_points = 25;

% 生成非均匀插值点
t_interp = linspace(0, cumulative_curvature(end), num_points);

% 使用非均匀插值
x_interp = interp1(cumulative_curvature, x, t_interp, 'pchip', 'extrap');
y_interp = polyval(coefficients, x_interp);

% 绘制原始曲线和插值曲线
figure(1);
plot(x,y,'go','DisplayName', 'Original points');
hold on;
plot(x,y,'r-','DisplayName', 'Original Curve')
hold on;
plot(xx, yy, '*b-', 'DisplayName', 'Original Curve Function');
legend;
xlabel('Number of points / X-axis');
ylabel('Value of points / Y-axis');
hold off;

figure(2);
plot(xx, yy, '*b', 'DisplayName', 'Original Curve Function');
hold on;
plot(x_interp, y_interp, 'or-', 'DisplayName', 'New Interpolated Curve');
xlabel('Number of points / X-axis');
ylabel('Value of points / Y-axis');
legend;

%% 计算点与点之间的长度并绘制出来
for i=1:length(xx)-1
    lOriginal(i) = sqrt( abs((xx(i+1)-xx(i))^2+(yy(i+1)-yy(i))^2 ) );
end

for i=1:length(x_interp)-1
    lnew(i) = sqrt( abs(  (x_interp(i+1)-x_interp(i))^2+(y_interp(i+1)-y_interp(i))^2  ));
end

% 计算曲率
curvature = computeCurvature(x_interp, y_interp);

figure(3);
bar(1:length(x_interp),curvature*50,'DisplayName', 'Points curvature*50')

hold on;
plot(1:length(x_interp)-1,lnew,'b','DisplayName', 'Length of original points');
hold on;
plot(1:length(xx)-1,lOriginal,'r','DisplayName', 'Length of new points');
xlabel('Number of points / X-axis');
ylabel('Value of points / Y-axis');
legend;