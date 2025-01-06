%% 此程序为matlab编程实现的BP神经网络
% 清空环境变量
clear
close all
clc

%%第一步 读取数据
input=[248.00 	300.20 	363.60 
300.20 	363.60 	408.40 
363.60 	408.40 	542.30 
408.40 	542.30 	695.67 
542.30 	695.67 	947.95 
695.67 	947.95 	1179.90 
947.95 	1179.90 	1077.33 
1179.90 	1077.33 	1452.80 
1077.33 	1452.80 	1862.03 
1452.80 	1862.03 	2410.57 
1862.03 	2410.57 	3229.83 
2410.57 	3229.83 	3830.04 
3229.83 	3830.04 	4838.84 
3830.04 	4838.84 	6137.60 
4838.84 	6137.60 	7600.52 
6137.60 	7600.52 	8825.39 
7600.52 	8825.39 	10012.72 
8825.39 	10012.72 	11454.48];  %载入输入数据
output=[408.40 
542.30 
695.67 
947.95 
1179.90 
1077.33 
1452.80 
1862.03 
2410.57 
3229.83 
3830.04 
4838.84 
6137.60 
7600.52 
8825.39 
10012.72 
11454.48 
7170.07];  %载入输出数据

%% 第二步 设置训练数据和预测数据
input_train = input(1:15,:)';
output_train =output(1:15,:)';
input_test = input(16:18,:)';
output_test =output(16:18,:)';
%节点个数
inputnum=3; % 输入层节点数量
hiddennum=11;% 隐含层节点数量
outputnum=1; % 输出层节点数量
%% 第三本 训练样本数据归一化
[inputn,inputps]=mapminmax(input_train);%归一化到[-1,1]之间，inputps用来作下一次同样的归一化
[outputn,outputps]=mapminmax(output_train);



%% 第四步 构建BP神经网络
net=newff(inputn,outputn,hiddennum,{'tansig','purelin'},'trainlm');% 建立模型，传递函数使用purelin，采用梯度下降法训练

W1= net.iw{1, 1};%输入层到中间层的权值
B1 = net.b{1};%中间各层神经元阈值

W2 = net.lw{2,1};%中间层到输出层的权值
B2 = net. b{2};%输出层各神经元阈值

%% 第五步 网络参数配置（ 训练次数，学习速率，训练目标最小误差等）
net.trainParam.epochs=1000;         % 训练次数，这里设置为1000次
net.trainParam.lr=0.01;                   % 学习速率，这里设置为0.01
net.trainParam.goal=0.00001;                    % 训练目标最小误差，这里设置为0.00001
net.trainParam.showWindow = 0;             % 0关闭窗口


%% 第六步 BP神经网络训练
net=train(net,inputn,outputn);%开始训练，其中inputn,outputn分别为输入输出样本

%% 第七步 测试样本归一化
inputn_test=mapminmax('apply',input_test,inputps);% 对样本数据进行归一化

%% 第八步 BP神经网络预测
an=sim(net,inputn_test); %用训练好的模型进行仿真

%% 第九步 预测结果反归一化与误差计算     
test_simu=mapminmax('reverse',an,outputps); %把仿真得到的数据还原为原始的数量级
error=test_simu-output_test;      %预测值和真实值的误差

%对训练集的仿真
an0=sim(net,inputn);
train_simu=mapminmax('reverse',an0,outputps); 
figure('units','normalized','position',[0.119 0.2 0.38 0.5])
plot(output_train,'bo-','markersize',10,'markerfacecolor','b')
hold on
plot(train_simu,'rs-','markersize',10,'markerfacecolor','r')
grid on  %添加网格线

legend('期望值','预测值')
xlabel('数据组数')
ylabel('样本值')
title('BP神经网络训练集的预测值与实际值对比图')


%%第十步 真实值与预测值误差比较
figure('units','normalized','position',[0.5 0.2 0.38 0.5])
plot(output_test,'bo-','markersize',10,'markerfacecolor','b')
hold on
plot(test_simu,'rs-','markersize',10,'markerfacecolor','r')
grid on  %添加网格线

legend('期望值','预测值')
xlabel('数据组数')
ylabel('样本值')
title('BP神经网络测试集的预测值与实际值对比图')

[c,l]=size(output_test);
MAE1=sum(abs(error))/l;
MSE1=error*error'/l;
RMSE1=MSE1^(1/2);

MAPE1=sum(abs(error./output_test))/l;

R = corrcoef(output_test,test_simu);
R2= R(1,2)^2

disp(['-----------------------误差计算--------------------------'])
disp(['隐含层节点数为',num2str(hiddennum),'时的误差结果如下：'])
disp(['平均绝对误差MAE为：',num2str(MAE1)])
disp(['均方误差MSE为：       ',num2str(MSE1)])
disp(['均方根误差RMSE为：  ',num2str(RMSE1)])

disp(['平均相对误差MAPE为：  ',num2str(MAPE1)])

disp(['决定系数R^2为：  ',num2str(R2)])
