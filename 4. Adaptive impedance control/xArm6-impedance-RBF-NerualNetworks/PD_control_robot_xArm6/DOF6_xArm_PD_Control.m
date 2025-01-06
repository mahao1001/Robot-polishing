function y = DOF6_xArm_PD_Control(x)

P = x(1);
D = x(2);


% 调整参数作为尝试
    load_system("DOF6_xArm_PD_Controller.slx")
    set_param('DOF6_xArm_PD_Controller/P','Value','P')    
    set_param('DOF6_xArm_PD_Controller/D','Value','D')
    sim("DOF6_xArm_PD_Controller.slx")    

    %% 计算输入与输出直接计算误差
    output =load('output.mat');
    input = load('input.mat');
    e1 = output.output(2,:) - input.input(2,:);
    e2 = output.output(3,:) - input.input(3,:);
    e3 = output.output(4,:) - input.input(4,:);
    e4 = output.output(5,:) - input.input(5,:);
    e5 = output.output(6,:) - input.input(6,:);
    e6 = output.output(7,:) - input.input(7,:);
    % ISE = sum(e.^2); % 计算误差平方的累积和
    IAE = sum(abs(e1)+abs(e2)+abs(e3)+abs(e4)+abs(e5)+abs(e6)); % 计算误差绝对值的累积和
    % ITSE = sum(t .* e.^2); % 计算误差平方乘以时间的累积和
    % ITAE = sum(t .* abs(e)); % 计算误差绝对值乘以时间的累积和
       y = IAE;

end
