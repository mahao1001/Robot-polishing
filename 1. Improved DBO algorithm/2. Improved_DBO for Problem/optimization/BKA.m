%________________________________________________________ ________________%
%  Black-winged Kite Algorithm (BKA) source codes                         %
%                                                                         %
%  Developed in MATLAB R2022b                                             %
%                                                                         %
%  Author and programmer:                                                 %
%  Black-winged Kite Algorithm: A nature-inspired meta-heuristic for
%              Solving benchmark functions and Engineering problems                                                                       %
%  e-Mail:                                                                %
%  Artificial Intelligence Review                                                                      %                                                                        %
%  DOI:                                                                   %
%                                                                         %
%_________________________________________________________________________%
%%
%%  Black-winged Kite Algorithm
function [Best_Fitness_BKA,Best_Pos_BKA,Convergence_curve]=BKA(pop,T,lb,ub,dim,fobj)
%% ----------------Initialize the locations of Blue Sheep------------------%
p=0.9;
% r=rand; % 原始
XPos=initialization(pop,dim,ub,lb);% Initial population
for i =1:pop
    XFit(i)=fobj(XPos(i,:));
end
Convergence_curve=zeros(1,T);
%% -------------------Start iteration------------------------------------%
for t=1:T
    r=rand; % 新加
    [~,sorted_indexes]=sort(XFit);
    XLeader_Pos=XPos(sorted_indexes(1),:);
    XLeader_Fit = XFit(sorted_indexes(1));
   
%% -------------------Attacking behavior-------------------%
    for i=1:pop
        
        n=0.05*exp(-2*(t/T)^2);
        if p<r
            XPosNew(i,:)=XPos(i,:)+n.*(1+sin(r))*XPos(i,:);
        else
            XPosNew(i,:)= XPos(i,:).*(n*(2*rand(1,dim)-1)+1);
        end
        XPosNew(i,:) = max(XPosNew(i,:),lb);XPosNew(i,:) = min(XPosNew(i,:),ub);%%Boundary checking
%% ------------ Select the optimal fitness value--------------%
        
        XFit_New(i)=fobj(XPosNew(i,:));
        if(XFit_New(i)<XFit(i))
            XPos(i,:) = XPosNew(i,:);
            XFit(i) = XFit_New(i);
        end
%% -------------------Migration behavior-------------------%
 
        m=2*sin(r+pi/2);
        s = randi([1,30],1);
        r_XFitness=XFit(s);
        ori_value = rand(1,dim);cauchy_value = tan((ori_value-0.5)*pi);
        if XFit(i)< r_XFitness
            XPosNew(i,:)=XPos(i,:)+cauchy_value(:,dim).* (XPos(i,:)-XLeader_Pos);
        else
            XPosNew(i,:)=XPos(i,:)+cauchy_value(:,dim).* (XLeader_Pos-m.*XPos(i,:));
        end
        XPosNew(i,:) = max(XPosNew(i,:),lb);XPosNew(i,:) = min(XPosNew(i,:),ub); %%Boundary checking
%% --------------  Select the optimal fitness value---------%
        XFit_New(i)=fobj(XPosNew(i,:));
        if(XFit_New(i)<XFit(i))
            XPos(i,:) = XPosNew(i,:);
            XFit(i) = XFit_New(i);
        end
    end
    %% -------Update the optimal Black-winged Kite----------%
    if(XFit<XLeader_Fit)
        Best_Fitness_BKA=XFit(i);
        Best_Pos_BKA=XPos(i,:);
    else
        Best_Fitness_BKA=XLeader_Fit;
        Best_Pos_BKA=XLeader_Pos;
    end
    Convergence_curve(t)=Best_Fitness_BKA;
end
end
