close all;clear;clc
% 响应面模型 ANOVA分析评估特征变量及其交互作用对输出值的显著性 mahao1001@outlook.com 
%%
% 1. 导入数据 (假设数据在一个 Excel 文件中)
data = readtable('robot_polishing24.xlsx'); % 确保文件名正确并在工作路径中

% 2. 提取相关列
x1 = data.Feature1; % 特征1
x2 = data.Feature2; % 特征2
z = data.Output;    % 输出

% 构造设计矩阵 (包括主效应、二次效应和交互效应)
X = [ones(size(x1)), x1, x2, x1.^2, x2.^2, x1.*x2];

% 使用线性模型拟合
lm = fitlm(X, z); % 拟合线性模型

% 方差分析
anova_table = anova(lm, 'summary');
disp('ANOVA Table:');
disp(anova_table);

% 显示回归模型的统计信息
disp('回归模型的统计信息:');
disp(lm);


% 可视化主效应
figure;
plotEffects(lm);
title('Main Effects Plot');

% 可视化交互作用
figure;
plotInteraction(lm, 2, 3); % 特征1和特征2交互作用
title('Interaction Plot');

