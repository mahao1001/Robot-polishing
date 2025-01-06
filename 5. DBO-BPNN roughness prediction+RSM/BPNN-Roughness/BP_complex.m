%% 原始BP神经网络，随机初始化
%  项目：表面粗糙度预测。 联系人：马浩浩，邮箱：mahao1001@tsnu.edu.cn
%  可自行修改输入与输出数据
%  P是实验输入数据，分为P_train 和 P_test
%  T是实验输出数据。对应T_train 和 T_test
%  神经网络预测结果，对应T_sim1  和 T_sim2
%  误差对比T_train 和 T_sim1
%  误差对比P_train 和 P_sim1
%%
clear
clc
%% 构造数据集 导入现有的数据集
% load building_dataset                           %导入建筑能源数据
% [X,T] = building_dataset;

%% 导入实验获得的数据集，这个地方的是4输入1输出问题
%% 第一种直接导入.mat数据
% load('input.mat')
% load('output.mat')
% X = input';      % 输入，样本数据116组
% T = output';     % 输出，样本数据116组
%% 第二种从Excel中读取
dataset = xlsread('robot_polishing.xlsx');
dataset = [dataset;dataset;dataset;dataset;dataset];
X =  dataset(:,1:4)';
T =  dataset(:,5)';
%%
inputDim=size(X,1);                             %输入数据维数
inputNum=size(X,2);                             %输入数据个数 
P = X;                                          %自变量  
T = T;                                          %目标

inputnum=size(P,1);                             % 输入层神经元个数     1表示行数，2表示列数
hiddennum=2*inputnum+1;                         % 隐含层神经元个数     数据维度的两倍+1  行数
outputnum=size(T,1);                            % 输出层神经元个数     数据维度   行数 
%%  划分数据集
temp = randperm(inputNum);   %整数之间随机置换 会把1到inputNum之间的整数随机置换，包含边界
P_train=P(:,temp(1:0.9*inputNum)); %随机取百分之90的数据X
T_train=T(:,temp(1:0.9*inputNum));  %随机取百分之90的数据Y
P_test=P(:,temp(0.9*inputNum+1:end)); %随机取百分之10的数据X
T_test=T(:,temp(0.9*inputNum+1:end));  %随机取百分之10的数据Y
M = size(P_train, 2);
N = size(P_test, 2);
%% 数据归一化
[p_train,ps_train]=mapminmax(P_train,0,1); %最大最小归一化 0,1是缩放后的最大最小值  按行归一化，即归一化后一行最大是1，最小是0
p_test = mapminmax('apply',P_test,ps_train); %归一化后的数组
[t_train,ps_output]=mapminmax(T_train,0,1);  %归一化
%% 开始构建BP网络
net = newff(p_train,t_train,hiddennum,{'tansig','purelin'},'trainlm');         %X 隐含层为hiddennum个神经元  Y
%设定参数网络参数，训练次数为1000，训练目标为0.00001，学习速率为0.1
net.trainParam.epochs = 1000;
net.trainParam.goal = 0;%1e-5;
net.trainParam.lr = 0.1;
% net.trainParam.showwindow=false;                %高版MATLAB使用 不显示图形框
%% 开始训练
net = train(net,p_train,t_train);  %神经网络  X Y
%% 测试网络
t_sim = sim(net,p_test);   
T_sim = mapminmax('reverse',t_sim,ps_output);   %反归一化
err=norm(T_sim-T_test);                         %预测结果与测试结果差的范数，范数越小说明预测得越准确，如果范数为0，说明预测得完全准确
rsquare=Rsquare_cal(T_sim,T_test);
%% 查看训练后的权值与阈值
w1=net.iw{1,1};                                 %初始输入层到隐含层的权值
B1=net.b{1};                                    %隐层神经元阈值
w2=net.lw{2,1};                                 %初始隐层到输出层的权值
B2=net.b{2};                                    %输出层阈值

%%
%%
%%  仿真预测
t_sim1 = sim(net, p_train);
t_sim2 = sim(net, p_test );

%%  数据反归一化
T_sim1 = mapminmax('reverse', t_sim1, ps_output);
T_sim2 = mapminmax('reverse', t_sim2, ps_output);

%%  均方根误差
error1 = sqrt(sum((T_sim1 - T_train).^2, 2)' ./ M);
error2 = sqrt(sum((T_sim2 - T_test) .^2, 2)' ./ N);

%%  绘图
figure
plot(1: M, T_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'训练集预测结果对比'; ['RMSE=' num2str(error1)]};
title(string)
xlim([1, M])
grid

figure
plot(1: N, T_test, 'r-*', 1: N, T_sim2, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'测试集预测结果对比'; ['RMSE=' num2str(error2)]};
title(string)
xlim([1, N])
grid
