clear;clc;
%%
% 假设 normal_vectors 是包含曲面法向量的数组或矩阵，每一行代表一个法向量
% 例如：normal_vectors = [n1_x, n1_y, n1_z; n2_x, n2_y, n2_z; ...]
load('normals.mat')
normal_vectors = normals;
% normal_vectors = [-0.913200629795594	-0.369807252011574	0.171193475636715];
num_points = size(normal_vectors, 1);
quaternions = zeros(num_points, 4); % 初始化存储四元数的数组

for i = 1:num_points
    % 构建旋转矩阵
    x_axis = [1, 0, 0]; % 选择一个与 X 轴垂直的向量
    y_axis = cross(normal_vectors(i, :), x_axis); % 计算与法向量垂直的向量
    y_axis = y_axis / norm(y_axis); % 归一化
    z_axis = normal_vectors(i, :); % 法向量作为 Z 轴
    
    rotation_matrix = [x_axis; y_axis; z_axis]; % 构建旋转矩阵
    
    % 旋转矩阵转换为四元数
    quaternion = rotm2quat(rotation_matrix);
    quaternions(i, :) = quaternion; % 存储四元数
end