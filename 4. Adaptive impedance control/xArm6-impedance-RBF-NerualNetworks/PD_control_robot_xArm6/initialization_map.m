close all;
clear;clc;

% 输入参数
pop=300;
dim=3;
lb=[-10,-5,-15];
ub=[10,5,15];


% 计算种群
positons = initializationLogistic(pop,dim,ub,lb);


%% 随机方法
% 参数设置
population_size = 300;
dimension = 3;
search_space = [-10 10; -5 5; -15 15]; % 三维搜索空间，每个维度的取值范围

% 初始化种群
population = zeros(population_size, dimension);
for i = 1:population_size
    for d = 1:dimension
        min_limit = search_space(d, 1);
        max_limit = search_space(d, 2);
        population(i, d) = min_limit + rand() * (max_limit - min_limit);
    end
end

%% 绘制对比图
figure;
scatter3(population(:,1), population(:,2), population(:,3), 'b');
hold on;
scatter3(positons(:,1), positons(:,2), positons(:,3), 'filled','r');
% title('蜣螂算法种群初始化分布');
xlabel('Dimension 1');
ylabel('Dimension 2');
zlabel('Dimension 3');
legend('Original','Proposed')
% view(45,45);