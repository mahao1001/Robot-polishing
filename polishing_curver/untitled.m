% 设置参数
Fs = 50;            % 采样频率
T = 1/Fs;             % 采样周期
t = 0:T:1-T;          % 时间向量
f = 5;                % 信号频率
A = 1;                % 信号幅度
mu = 0.4;               % 均值
sigma = 0.02;          % 标准差

% 生成正弦信号
signal = A * sin(2*pi*f*t);

% 生成高斯噪声信号
noise = mu + sigma * randn(size(t));

% 将噪声添加到信号中
noisy_signal = signal + noise;

% 绘制信号和噪声
figure;
subplot(3,1,1);
plot(t, signal);
title('原始信号');

subplot(3,1,2);
plot(t, noise);
title('高斯噪声');

subplot(3,1,3);
plot(t, noisy_signal);
title('受噪声影响的信号');
