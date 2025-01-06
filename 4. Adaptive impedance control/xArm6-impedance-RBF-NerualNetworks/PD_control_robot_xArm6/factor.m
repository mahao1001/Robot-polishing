clear;clc;
    % 迭代次数
    num_iterations = 100;
    
    % 初始化数组以存储每个迭代步骤的收敛因子
    convergence_factors = zeros(1, num_iterations);
    
    % 计算收敛因子并记录
    for iteration = 1:num_iterations
        convergence_factors_original(iteration)= 1 - iteration / num_iterations;
       
        convergence_factors_sine(iteration) = 0.5+0.5*sin(pi/2+pi*(iteration/num_iterations)^1);
        
        convergence_factors_sine08(iteration) = 0.5+0.5*sin(pi/2+pi*(iteration/num_iterations)^0.8);

        convergence_factors_sine12(iteration) = 0.5+0.5*sin(pi/2+pi*(iteration/num_iterations)^1.2);
    end
    
    % 绘制收敛因子曲线
    plot(1:num_iterations, convergence_factors_original, 'b');
    hold on
    plot(1:num_iterations, convergence_factors_sine, '-o');
    plot(1:num_iterations, convergence_factors_sine08, 'c*');
    plot(1:num_iterations, convergence_factors_sine12, 'mo');
    % title('Convergence Factor Over Iterations');
    xlabel('Iteration k=0.8,1,1.2');
    ylabel('Convergence Factor');
    legend('original','Sine k=1','Sine k=0.8','Sine k=1.2');