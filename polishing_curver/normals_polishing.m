
clear;clc
%% 导入曲面曲线轨迹
num_points = 50;
[X,Y] = meshgrid(1:2:99);
Z =0.2*Y.*sin(X/20) -0.2* X.*cos(Y/20);
P0 = [X(:), Y(:), Z(:)];
[U,V,W] = surfnorm(Z);

size = length(X);
for i=1:size
    s = (i-1)*size+1;
    e = i*size;
    P =  [P0(s:e,1), P0(s:e,2), P0(s:e,3)];
    P1 = [P0(s:e,1)+200, P0(s:e,2)*3, 300+P0(s:e,3)*3];  
end


%% % 导入法向量
% load('normals2500.mat');
% normals = zeros(length(X),3);
normal = [U(:),V(:),W(:)];

for i=1:size
    s = (i-1)*size+1;
    e = i*size;
    normals =  [normal(s:e,1), normal(s:e,2), normal(s:e,3)];
end
% 计算法向量的方向
normals_normalized = normals ./ vecnorm(normals, 2, 2);
%% 绘制法向量
points =P;

% 绘制曲线
figure;
plot3(points(:, 1), points(:, 2), points(:, 3), '-o');
hold on;

% 绘制法向量
scale_factor = 1;  % 缩放因子，控制法向量的长度

for i = 1:50
    quiver3(points(i, 1), points(i, 2), points(i, 3), ...
            normals_normalized(i, 1)*scale_factor, normals_normalized(i, 2)*scale_factor, normals_normalized(i, 3)*scale_factor, ...
            'Color', 'r', 'LineWidth', 2);
end

hold off;

title('空间曲线与法向量');
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
grid on;




