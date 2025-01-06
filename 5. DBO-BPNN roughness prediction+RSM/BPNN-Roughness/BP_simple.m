%% �˳���Ϊmatlab���ʵ�ֵ�BP������
% ��ջ�������
clear
close all
clc

%%��һ�� ��ȡ����
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
8825.39 	10012.72 	11454.48];  %������������
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
7170.07];  %�����������

%% �ڶ��� ����ѵ�����ݺ�Ԥ������
input_train = input(1:15,:)';
output_train =output(1:15,:)';
input_test = input(16:18,:)';
output_test =output(16:18,:)';
%�ڵ����
inputnum=3; % �����ڵ�����
hiddennum=11;% ������ڵ�����
outputnum=1; % �����ڵ�����
%% ������ ѵ���������ݹ�һ��
[inputn,inputps]=mapminmax(input_train);%��һ����[-1,1]֮�䣬inputps��������һ��ͬ���Ĺ�һ��
[outputn,outputps]=mapminmax(output_train);



%% ���Ĳ� ����BP������
net=newff(inputn,outputn,hiddennum,{'tansig','purelin'},'trainlm');% ����ģ�ͣ����ݺ���ʹ��purelin�������ݶ��½���ѵ��

W1= net.iw{1, 1};%����㵽�м���Ȩֵ
B1 = net.b{1};%�м������Ԫ��ֵ

W2 = net.lw{2,1};%�м�㵽������Ȩֵ
B2 = net. b{2};%��������Ԫ��ֵ

%% ���岽 ����������ã� ѵ��������ѧϰ���ʣ�ѵ��Ŀ����С���ȣ�
net.trainParam.epochs=1000;         % ѵ����������������Ϊ1000��
net.trainParam.lr=0.01;                   % ѧϰ���ʣ���������Ϊ0.01
net.trainParam.goal=0.00001;                    % ѵ��Ŀ����С����������Ϊ0.00001
net.trainParam.showWindow = 0;             % 0�رմ���


%% ������ BP������ѵ��
net=train(net,inputn,outputn);%��ʼѵ��������inputn,outputn�ֱ�Ϊ�����������

%% ���߲� ����������һ��
inputn_test=mapminmax('apply',input_test,inputps);% ���������ݽ��й�һ��

%% �ڰ˲� BP������Ԥ��
an=sim(net,inputn_test); %��ѵ���õ�ģ�ͽ��з���

%% �ھŲ� Ԥ��������һ����������     
test_simu=mapminmax('reverse',an,outputps); %�ѷ���õ������ݻ�ԭΪԭʼ��������
error=test_simu-output_test;      %Ԥ��ֵ����ʵֵ�����

%��ѵ�����ķ���
an0=sim(net,inputn);
train_simu=mapminmax('reverse',an0,outputps); 
figure('units','normalized','position',[0.119 0.2 0.38 0.5])
plot(output_train,'bo-','markersize',10,'markerfacecolor','b')
hold on
plot(train_simu,'rs-','markersize',10,'markerfacecolor','r')
grid on  %���������

legend('����ֵ','Ԥ��ֵ')
xlabel('��������')
ylabel('����ֵ')
title('BP������ѵ������Ԥ��ֵ��ʵ��ֵ�Ա�ͼ')


%%��ʮ�� ��ʵֵ��Ԥ��ֵ���Ƚ�
figure('units','normalized','position',[0.5 0.2 0.38 0.5])
plot(output_test,'bo-','markersize',10,'markerfacecolor','b')
hold on
plot(test_simu,'rs-','markersize',10,'markerfacecolor','r')
grid on  %���������

legend('����ֵ','Ԥ��ֵ')
xlabel('��������')
ylabel('����ֵ')
title('BP��������Լ���Ԥ��ֵ��ʵ��ֵ�Ա�ͼ')

[c,l]=size(output_test);
MAE1=sum(abs(error))/l;
MSE1=error*error'/l;
RMSE1=MSE1^(1/2);

MAPE1=sum(abs(error./output_test))/l;

R = corrcoef(output_test,test_simu);
R2= R(1,2)^2

disp(['-----------------------������--------------------------'])
disp(['������ڵ���Ϊ',num2str(hiddennum),'ʱ����������£�'])
disp(['ƽ���������MAEΪ��',num2str(MAE1)])
disp(['�������MSEΪ��       ',num2str(MSE1)])
disp(['���������RMSEΪ��  ',num2str(RMSE1)])

disp(['ƽ��������MAPEΪ��  ',num2str(MAPE1)])

disp(['����ϵ��R^2Ϊ��  ',num2str(R2)])
