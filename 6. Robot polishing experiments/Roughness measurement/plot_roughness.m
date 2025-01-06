close all;
clear;clc;

% 定义文件名列表
filePaths = {'S7-C.xlsx', 'S8-C.xlsx', 'S3-A.xlsx'}; % 替换为你的文件名
sheetName = 'DATA'; % 工作表名称

% 初始化图像
figure('Position', [100, 100, 1000, 600]);
hold on;
colors = lines(length(filePaths)); % 自动分配颜色

for i = 1:length(filePaths)
    % 读取 E 列和 F 列数据
    dataE = readmatrix(filePaths{i}, 'Sheet', sheetName, 'Range', 'E:E'); % 读取 E 列
    dataF = readmatrix(filePaths{i}, 'Sheet', sheetName, 'Range', 'F:F'); % 读取 F 列
    
    % 绘制数据
    plot(dataE, dataF,  'LineWidth', 1,  'Color', colors(i, :));
end

% 添加图例、标题和轴标签
legend('Original surface profile: 1.5994 μm','Original polished profile: 0.79831 μm','Proposed polished profile: 0.48509 μm');
grid on;
hold off;

% title('Evaluation Profile');
xlabel('Sampling (mm)');
ylabel('Roughness (μm)');
grid on;
