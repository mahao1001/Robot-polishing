% -----------------------------------------------------------------------------------------------------------
% Dung Beetle Optimizer: (DBO) (demo)
% Programmed by Jian-kai Xue    
% Updated 28 Nov. 2022.                     
%
% This is a simple demo version only implemented the basic         
% idea of the DBO for solving the unconstrained problem.    
% The details about DBO are illustratred in the following paper.    
% (To cite this article):                                                
%  Jiankai Xue & Bo Shen (2022) Dung beetle optimizer: a new meta-heuristic
% algorithm for global optimization. The Journal of Supercomputing, DOI:
% 10.1007/s11227-022-04959-6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear;clc;

SearchAgents_no=30; % Number of search agents

Max_iteration=1; % Maximum numbef of iterations

% Load details of the selected benchmark function
% [lb,ub,dim,fobj]=Get_Functions_details(Function_name);
lb = [0,   0];
ub = [200,200];
dim = 2;


%% 调用机器人并加载逆运动学求出来的关节角度
[DOF6_xArm6, ArmInfo] = importrobot('DOF6_xArm');  % 加载机器人模型
load('qrt.mat')
num = (1:410:4187);
qrt = qrt(:,num);
joint_angle = qrt(2:end,:);
joint_time = qrt(1,:);
joint_angle(:,1) = zeros(6,1);     % 初始转角为0
joint_angle(:,end) = zeros(6,1);   % 结束转角为0

%% 调整参数作为尝试
    P =1; D =1;
    load_system("DOF6_xArm_PD_Controller.slx") 
    sim("DOF6_xArm_PD_Controller.slx") 
    output =load('output.mat');
    input = load('input.mat');
    % figurename = sprintf('Kp=%d Kd=%d', P, D);
    subplot(3,2,1);
    plot(output.output(1,:),output.output(2,:),'DisplayName','q1m');
    hold on
    plot(input.input(1,:),input.input(2,:),'DisplayName','q1');
    legend('show');% 创建图例
    subplot(3,2,2);
    plot(output.output(1,:),output.output(3,:),'DisplayName','q2m')
    hold on
    plot(input.input(1,:),input.input(3,:),'DisplayName','q2');
    legend('show');% 创建图例
    subplot(3,2,3);
    plot(output.output(1,:),output.output(4,:),'DisplayName','q3m')
    hold on
    plot(input.input(1,:),input.input(4,:),'DisplayName','q3');
    legend('show');% 创建图例
    subplot(3,2,4);
    plot(output.output(1,:),output.output(5,:),'DisplayName','q4m')
    hold on
    plot(input.input(1,:),input.input(5,:),'DisplayName','q4');
    legend('show');% 创建图例
    subplot(3,2,5);
    plot(output.output(1,:),output.output(6,:),'DisplayName','q5m')
    hold on
    plot(input.input(1,:),input.input(6,:),'DisplayName','q5');
    legend('show');% 创建图例
    subplot(3,2,6);
    plot(output.output(1,:),output.output(7,:),'DisplayName','q6m')
    hold on
    plot(input.input(1,:),input.input(7,:),'DisplayName','q6');
    legend('show');% 创建图例
    title = ('Kp=1 Kd=1');
    saveas(gcf, 'Kp=1,Kd=1');    % 最后保存一次
    hold off


fobj = @(x)DOF6_xArm_PD_Control(x);  

[fMin,bestX,DBO_curve]=DBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

figure;
semilogy(DBO_curve,'Color','r','LineWidth',1.5)
% title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');
%axis tight
grid on
box on
legend('IDBO')
display(['The best solution obtained by DBO is : ', num2str(bestX)]);
display(['The best optimal value of the objective funciton found by DBO is : ', num2str(fMin)]);
hold off

%% 计算保存PD值
P = bestX(1);
D = bestX(2);
save('PD.mat', 'bestX'); 

set_param('DOF6_xArm_PD_Controller/P','Value','P')
set_param('DOF6_xArm_PD_Controller/D','Value','D')
sim("DOF6_xArm_PD_Controller.slx")
output =load('output.mat');
input = load('input.mat');

%% 绘制
figure   
figurename = sprintf('Kp=%10.3f Kd=%10.3f', P, D);   % 显示三位小数
subplot(3,2,1);
plot(output.output(1,:),output.output(2,:),'DisplayName','q1m');
hold on
plot(input.input(1,:),input.input(2,:),'DisplayName','q1');
legend('show');% 创建图例
subplot(3,2,2);
plot(output.output(1,:),output.output(3,:),'DisplayName','q2m')
hold on
plot(input.input(1,:),input.input(3,:),'DisplayName','q2');
legend('show');% 创建图例
subplot(3,2,3);
plot(output.output(1,:),output.output(4,:),'DisplayName','q3m')
hold on
plot(input.input(1,:),input.input(4,:),'DisplayName','q3');
legend('show');% 创建图例
subplot(3,2,4);
plot(output.output(1,:),output.output(5,:),'DisplayName','q4m')
hold on
plot(input.input(1,:),input.input(5,:),'DisplayName','q4');
legend('show');% 创建图例
subplot(3,2,5);
plot(output.output(1,:),output.output(6,:),'DisplayName','q5m')
hold on
plot(input.input(1,:),input.input(6,:),'DisplayName','q5');
legend('show');% 创建图例
subplot(3,2,6);
plot(output.output(1,:),output.output(7,:),'DisplayName','q6m')
hold on
plot(input.input(1,:),input.input(7,:),'DisplayName','q6');
legend('show');% 创建图例
saveas(gcf, 'Tuned PD');    % 最后保存一次
hold off


