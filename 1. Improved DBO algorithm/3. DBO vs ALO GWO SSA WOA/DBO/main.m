% -----------------------------------------------------------------------------------------------------------
% Dung Beetle Optimizer: (DBO) (demo)
% Programmed by Jian-kai Xue    
% Updated 28 Nov. 2022.                     
%
% This is a simple demo version only implemented the basic         
% idea of the DBO for solving the unconstrained problem.    
% The details about DBO are illustratred in the following paper.    
% (To cite this article):                                                
%  Jiankai Xue & Bo Shen (2022) Dung beetle optimizer: a new meta-heuristic
% algorithm for global optimization. The Journal of Supercomputing, DOI:
% 10.1007/s11227-022-04959-6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all 
clc

SearchAgents_no=30; % Number of search agents

% Function_name='F8'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)

Max_iteration=100; % Maximum numbef of iterations

% % Load details of the selected benchmark function
% [lb,ub,dim,fobj]=Get_Functions_details(Function_name);


%% 正压力10-40N，进给速度
lb=[10,50,3500];
ub=[30,300,15000];
dim=3;
fobj= @(Frv) polishing_Function(Frv);


[fMin,bestX,DBO_curve]=DBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
semilogy(DBO_curve,'Color','r')
% title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');
%axis tight
grid on
box on
legend('DBO')
display(['The best solution obtained by DBO is : ', num2str(bestX)]);
display(['The best optimal value of the objective funciton found by DBO is : ', num2str(fMin)]);




