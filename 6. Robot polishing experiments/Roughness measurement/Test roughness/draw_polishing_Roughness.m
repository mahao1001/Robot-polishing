close all;
clear; clc;
%% data 
load('z1.mat')
load('z2.mat')
load('z3.mat')

A = [0,100];
B = [-4.9,4.4];
X = 0:100;


figure;                       % 绘制结果
plot(A,B,'black',LineStyle="--",LineWidth=1);
hold on
plot(X,z1,'b',LineWidth=1);
hold on
plot(X,z2,'g',LineWidth=1);
hold on
plot(X,z3,'r',LineWidth=1.5);
xlim([1 100]);          % X轴固定区间

box on;                      
% title('Roughness data draw');         % 图标题
xlabel('X (μm)');          % X轴标尺
ylabel('Y (μm)');     % Y轴标尺
legend('Fitting curver','Original Profile','Polishing Profile','Adaptive Polishing');    % 解释曲线