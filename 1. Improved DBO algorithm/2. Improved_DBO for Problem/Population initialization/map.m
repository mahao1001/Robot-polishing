close all;
clear;clc;
%% 佳点集 Good point set method
% 分别画出2维，3维情况下采用佳点集和随机生成图的对比
% 定于种群大小
pop_size = 100;
% 定义种群的取值范围 
dimension_2 = 2;
dimension_3 = 3;
bounds_2 = [ones(dimension_2,1)*0,ones(dimension_2,1)*100];
bounds_3 = [ones(dimension_3,1)*0,ones(dimension_3,1)*100];
% 二维、三维的佳点集种群
pop2 = init_pop(pop_size,dimension_2,bounds_2);
pop3 = init_pop(pop_size,dimension_3,bounds_3);
% 二维、三维随机生成的种群
pop2_rand = init_pop_rand(pop_size,dimension_2,bounds_2);
pop3_rand = init_pop_rand(pop_size,dimension_3,bounds_3);

%% 画二维三维图形佳点集种群，分离的
% subplot(2,2,1)
% plot(pop2(:,1),pop2(:,2),'.')
% subplot(2,2,2)
% plot(pop2_rand(:,1),pop2_rand(:,2),'.')
% subplot(2,2,3)
% plot3(pop3(:,1),pop3(:,2),pop3(:,3),'*')
% subplot(2,2,4)
% plot3(pop3_rand(:,1),pop3_rand(:,2),pop3_rand(:,3),'*')
%% 画画二维三维图形佳点集种群，重合的
figure(1)
scatter(pop2(:,1),pop2(:,2),'r')
hold on
scatter(pop2_rand(:,1),pop2_rand(:,2),'b','*')
xlabel('X dimension');
ylabel('Y dimension');
legend('GPS method','Random')
box on;
hold off
figure(2)
scatter3(pop3(:,1),pop3(:,2),pop3(:,3),'*')
hold on
scatter3(pop3_rand(:,1),pop3_rand(:,2),pop3_rand(:,3),'*')
xlabel('X dimension');
ylabel('Y dimension');
zlabel('Z dimension')
legend('Improved','Random')

%%
% pop_size：种群数量
% dimension：维度
% bound：取值范围
function pop = init_pop(pop_size,dimension,bounds)
%佳点集生成初始种群
p = zeros(pop_size,dimension);
prime_number_min = dimension*2 +3;
% 找到(prime_number_min-3)/2>=dimension的最小素数prime_number_min
while 1
    if isprime(prime_number_min)==1
        break;
    else
       prime_number_min = prime_number_min + 1;
    end
end

for i = 1:pop_size
    for j = 1:dimension
        r = mod(2*cos(2*pi*j/prime_number_min)*i,1);% 对应维度的r
%         r = mod(exp(j)*i,1);
        p(i,j) = bounds(j,1)+r*(bounds(j,2)-bounds(j,1));
    end
end
pop = p;
end
%%
function pop = init_pop_rand(pop_size,dimension,bounds)
%随机i生成定义域范围内种群
p = rand(pop_size,dimension);%生成popsize*dimension的0-1矩阵
for i = 1:dimension
    p(:,i) = bounds(i,1)+p(:,i)*(bounds(i,2)-bounds(i,1));
end
pop = p;
end

