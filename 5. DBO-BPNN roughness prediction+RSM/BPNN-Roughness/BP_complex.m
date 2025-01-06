%% ԭʼBP�����磬�����ʼ��
%  ��Ŀ������ֲڶ�Ԥ�⡣ ��ϵ�ˣ���ƺƣ����䣺mahao1001@tsnu.edu.cn
%  �������޸��������������
%  P��ʵ���������ݣ���ΪP_train �� P_test
%  T��ʵ��������ݡ���ӦT_train �� T_test
%  ������Ԥ��������ӦT_sim1  �� T_sim2
%  ���Ա�T_train �� T_sim1
%  ���Ա�P_train �� P_sim1
%%
clear
clc
%% �������ݼ� �������е����ݼ�
% load building_dataset                           %���뽨����Դ����
% [X,T] = building_dataset;

%% ����ʵ���õ����ݼ�������ط�����4����1�������
%% ��һ��ֱ�ӵ���.mat����
% load('input.mat')
% load('output.mat')
% X = input';      % ���룬��������116��
% T = output';     % �������������116��
%% �ڶ��ִ�Excel�ж�ȡ
dataset = xlsread('robot_polishing.xlsx');
dataset = [dataset;dataset;dataset;dataset;dataset];
X =  dataset(:,1:4)';
T =  dataset(:,5)';
%%
inputDim=size(X,1);                             %��������ά��
inputNum=size(X,2);                             %�������ݸ��� 
P = X;                                          %�Ա���  
T = T;                                          %Ŀ��

inputnum=size(P,1);                             % �������Ԫ����     1��ʾ������2��ʾ����
hiddennum=2*inputnum+1;                         % ��������Ԫ����     ����ά�ȵ�����+1  ����
outputnum=size(T,1);                            % �������Ԫ����     ����ά��   ���� 
%%  �������ݼ�
temp = randperm(inputNum);   %����֮������û� ���1��inputNum֮�����������û��������߽�
P_train=P(:,temp(1:0.9*inputNum)); %���ȡ�ٷ�֮90������X
T_train=T(:,temp(1:0.9*inputNum));  %���ȡ�ٷ�֮90������Y
P_test=P(:,temp(0.9*inputNum+1:end)); %���ȡ�ٷ�֮10������X
T_test=T(:,temp(0.9*inputNum+1:end));  %���ȡ�ٷ�֮10������Y
M = size(P_train, 2);
N = size(P_test, 2);
%% ���ݹ�һ��
[p_train,ps_train]=mapminmax(P_train,0,1); %�����С��һ�� 0,1�����ź�������Сֵ  ���й�һ��������һ����һ�������1����С��0
p_test = mapminmax('apply',P_test,ps_train); %��һ���������
[t_train,ps_output]=mapminmax(T_train,0,1);  %��һ��
%% ��ʼ����BP����
net = newff(p_train,t_train,hiddennum,{'tansig','purelin'},'trainlm');         %X ������Ϊhiddennum����Ԫ  Y
%�趨�������������ѵ������Ϊ1000��ѵ��Ŀ��Ϊ0.00001��ѧϰ����Ϊ0.1
net.trainParam.epochs = 1000;
net.trainParam.goal = 0;%1e-5;
net.trainParam.lr = 0.1;
% net.trainParam.showwindow=false;                %�߰�MATLABʹ�� ����ʾͼ�ο�
%% ��ʼѵ��
net = train(net,p_train,t_train);  %������  X Y
%% ��������
t_sim = sim(net,p_test);   
T_sim = mapminmax('reverse',t_sim,ps_output);   %����һ��
err=norm(T_sim-T_test);                         %Ԥ��������Խ����ķ���������ԽС˵��Ԥ���Խ׼ȷ���������Ϊ0��˵��Ԥ�����ȫ׼ȷ
rsquare=Rsquare_cal(T_sim,T_test);
%% �鿴ѵ�����Ȩֵ����ֵ
w1=net.iw{1,1};                                 %��ʼ����㵽�������Ȩֵ
B1=net.b{1};                                    %������Ԫ��ֵ
w2=net.lw{2,1};                                 %��ʼ���㵽������Ȩֵ
B2=net.b{2};                                    %�������ֵ

%%
%%
%%  ����Ԥ��
t_sim1 = sim(net, p_train);
t_sim2 = sim(net, p_test );

%%  ���ݷ���һ��
T_sim1 = mapminmax('reverse', t_sim1, ps_output);
T_sim2 = mapminmax('reverse', t_sim2, ps_output);

%%  ���������
error1 = sqrt(sum((T_sim1 - T_train).^2, 2)' ./ M);
error2 = sqrt(sum((T_sim2 - T_test) .^2, 2)' ./ N);

%%  ��ͼ
figure
plot(1: M, T_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
legend('��ʵֵ', 'Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('Ԥ����')
string = {'ѵ����Ԥ�����Ա�'; ['RMSE=' num2str(error1)]};
title(string)
xlim([1, M])
grid

figure
plot(1: N, T_test, 'r-*', 1: N, T_sim2, 'b-o', 'LineWidth', 1)
legend('��ʵֵ', 'Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('Ԥ����')
string = {'���Լ�Ԥ�����Ա�'; ['RMSE=' num2str(error2)]};
title(string)
xlim([1, N])
grid
