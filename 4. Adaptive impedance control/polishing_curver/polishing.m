clear,clc,close all;
%% 建立机器人DH参数，初始姿态
L1 = Link('d',267,'a',0,'alpha',-pi/2,'standard');
L2 = Link('d',0,'a',289.48866,'alpha',0,'offset',-1.3849179,'standard');
L3 = Link('d',0,'a',77.5,'alpha',-pi/2,'offset',1.3849179,'standard');
L4 = Link('d',342.5,'a',0,'alpha',pi/2,'standard');
L5 = Link('d',0,'a',76,'alpha',-pi/2,'standard');
L6 = Link('d',97,'a',0,'alpha',0,'standard');
robot = SerialLink([L1 L2 L3 L4 L5 L6],'name','Cobot xArm6');
robot.links
robot.name
robot.display;
%% 机器人预览
% Theta = [0 0 0 0 0 0];  %给定6个关节角度值
% W=[-800,+800,-800,+800,-800,+800];
% robot.plot(Theta,'tilesize',150,'workspace',W);  %显示三维动画
%% 定义圆的参数
% mm=1;
% n=[0 0 1];
% r=200*mm;
% c=[400 0 300]*mm;
% step=60;
% P=drawing_circle(n,r,c,step);   %画圆函数生成轨迹
%% 导入曲面曲线轨迹
num_points = 50;
[X,Y] = meshgrid(1:2:99);
Z =0.2*Y.*sin(X/20) -0.2* X.*cos(Y/20);
P0 = [X(:), Y(:), Z(:)];
size = length(X);
for i=1:size
    s = (i-1)*size+1;
    e = i*size;
    P = [P0(s:e,1)+200, P0(s:e,2)*4, 400+P0(s:e,3)*3];
end

%% 轨迹的姿态需要求解 待完成



%% 笛卡尔空间圆形逆解计算得到每个点的关节角度
iklnitGuess=zeros(1,6);
for i=1:length(P)
    Txyz = transl(P(i,:));           % 末端位置xyz转化为齐次坐标
    Trpy = rpy2tr([0,0,-180],'xyz');    % 末端姿态rpy角转化为齐次坐标形式，单位是deg
    T(:,:,i)=Txyz*Trpy;              % 使关节五始终竖直向下
        config=robot.ikunc(T(:,:,i),iklnitGuess); 
    iklnitGuess=config;
    qrt(i,:)=config;
end
%% 绘制末端轨迹
W=[-400,+900,-400,+900,-400,+900];
robot.plot(qrt,'tilesize',150,'workspace',W,'trail',{'r','LineWidth',3});  %显示三维动画
% title('Robot');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');

%% 验证正逆解的结果

qi=robot.ikine(T)*180/pi;      %求逆解验证关节角
% rot = t2r(T);                  %齐次矩阵变换为旋转矩阵
% Qua= UnitQuaternion(T);         %求四元数 
% 
% rpy=tr2rpy(T, 'xyz')*180/pi;    %求末端姿态，工具法兰为绕XYZ轴旋转
% robot.teach(T,'rpy' )          %显示roll/pitch/yaw angles，GUI可调界面

%% 绘制关节角度图
q1 = qi(:,1);
q2 = qi(:,2);q3 = qi(:,3);q4 = qi(:,4);q5 = qi(:,5);q6 = qi(:,6);

figure % 调整线条的颜色：'red'、'green'、'blue'、'cyan'、'magenta'、'yellow'、'black'、'white'
t = 0:1:num_points-1;
hold on;
grid on;
plot(t,q1,'Color','red','LineWidth',2,'LineStyle','-');
plot(t,q2,'Color','green','LineWidth',2,'LineStyle','-');
plot(t,q3,'Color','blue','LineWidth',2,'LineStyle','--');
plot(t,q4,'Color','cyan','LineWidth',2,'LineStyle',':');
plot(t,q5,'Color','r','LineWidth',2,'LineStyle','-');
plot(t,q6,'Color','yellow','LineWidth',2,'LineStyle','--');

% 添加图标
legend('Theta(joint1)', 'Theta(joint2)','Theta(joint3)','Theta(joint4)','Theta(joint5)','Theta(joint6)', 'Location', 'northeast');  % 图标文本和位置
% 添加轴标签和标题
xlabel('X轴');
ylabel('Y轴');
title('joint angle');

% 关闭绘图保持状态
hold off;
