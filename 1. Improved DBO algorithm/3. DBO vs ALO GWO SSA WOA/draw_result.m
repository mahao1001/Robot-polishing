close all
clear;clc;

load('ALO_curve.mat');
load('DBO_curve.mat');
load('GWO_curve.mat');
load('SSA_curve.mat');
load('WOA_curve.mat');

%% 绘制对应的曲线
% 调整线条的颜色：'red'、'green'、'blue'、'cyan'、'magenta'、'yellow'、'black'、'white'
figure;
% semilogy(I_DBO_data,'Color','red','LineWidth',2.5);
hold on;
semilogy(ALO_curve,'Color','blue','LineWidth',2,'LineStyle','-');  
semilogy(DBO_curve,'Color','red','LineWidth',2);
semilogy(GWO_curve,'Color','green','LineWidth',2);
semilogy(SSA_curve,'Color','black','LineWidth',1.5);
semilogy(WOA_curve,'Color','cyan','LineWidth',2);


% title(' swarm intelligence (SI) optimization algorithms')
xlabel('Iteration');
ylabel('Best score obtained so far');


axis tight
grid on
box on
legend('ALO','DBO','GWO','SSA','WOA')      % 给每条线加标签