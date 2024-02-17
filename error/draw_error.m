close all
clear; clc;

load('Orientation_error.mat');
load('Position_error.mat');

P = Position;
O = Orientation;

figure;                       % 绘制结果
plot(P,LineWidth=1.5);
xlim([size(P)]);
box on;                       % 图片边框开关 on off
% title('Image curve data capture and redraw');         % 图标题
xlabel('Index of path point');          % X轴标尺
ylabel('Comprehensive error (mm, 10^{-13})');     % Y轴标尺
hold off
Av1=mean(Position)
min(Position)


figure;                       % 绘制结果
plot(O,LineWidth=1.5);
xlim([size(O)]);
box on;                       % 图片边框开关 on off
% title('Image curve data capture and redraw');         % 图标题
xlabel('Index of path point');          % X轴标尺
ylabel('Comprehensive error value (rad, 10^{-14})');     % Y轴标尺
hold off
Av2=mean(Orientation)
min(Orientation)
