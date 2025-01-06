% https://doi.org/10.1155/2021/8548639
% https://doi.org/10.1016/j.engappai.2022.104805
% https://doi.org/10.1016/j.future.2019.02.028
% https://doi.org/10.1016/j.swevo.2020.100693

function [lb,ub,dim,fobj] = ProbInfo(F)

switch F
    case 1 % Three bar truss design
        fobj=@Design1;
        lb=0;
        ub=1;
        dim=2;
    case 2 % Welded beam structure problem
        fobj=@Design2;
        lb=[0.1 0.1 0.1 0.1];
        ub=[2 10 10 2];
        dim = 4;
    case 3 % tension/Compression spring design problem
        fobj=@Design3;
        lb = [0.05,0.25,2.00];
        ub=[2,1.3,15.0];
        dim =3;
    case 4 %Speed Reducer
        fobj=@Design4;
        lb= [2.6, 0.7, 17, 7.3, 7.3, 2.9, 5];
        ub= [3.6, 0.8, 28, 8.3, 8.3, 3.9, 5.5];
        dim=7;
    case 5 %Cantilever Beam
        fobj=@Design5;
        lb=0.01;
        ub=100;
        dim=5;
    case 6 %Pressure vessel design
        fobj=@Design6;
        lb = [0,0,0,0];
        ub = [99,99,200,200];
        dim=4;
    case 7 %I-beam vertical deflection
        fobj=@Design7;
        lb = [10 10 0.9 0.9];
        ub = [50 80 5.0 5.0];
        dim=4;
    case 8 %Design of gear train
        fobj=@Design8;
        lb=12;
        ub=60;
        dim=4;
    case 9 %Tubular column design
        fobj=@Design9;
        lb = [2 0.2];
        ub = [14 0.8];
        dim=2;
    case 10 %Corrugated bulkhead design
        fobj=@Design10;
        lb = [0 0 0 0];
        ub = [100 100 100 5];
        dim =4;
    case 11 %Piston lever
        fobj=@Design11;
        lb = [0.05 0.05 0.05 0.05];
        ub = [500 500 120 500];
        dim=4;
    case 12 %Reinforced concrete beam design
        fobj=@Design12;
        lb = [6 28 5];
        ub = [8 40 10];
        dim=3;
    case 13 %Car side impact design：https://doi.org/10.1016/j.istruc.2023.06.016
        fobj=@Design13;
        lb = [0.50 0.50 0.50 0.50 0.50 0.50 0.50 0 0 -30 -30];
        ub = [1.50 1.50 1.50 1.50 1.50 1.50 1.50 1 1 30 30];
        dim=length(lb);
    case 14 % Sawmill operation problem(https://arxiv.org/ftp/arxiv/papers/2112/2112.13508.pdf)
        fobj=@Design14;
        lb=[0,0,0,0];
        ub=[200,200,200,200];
        dim=length(lb);
    case 15 % hydro-static thrust bearing(https://doi.org/10.1016/j.eswa.2022.119246)
        fobj=@Design15;
        lb = [1e-6,1,1,1];
        ub=[1.6e-5,16,16,16];
        dim=length(lb);
    case 16 % Rolling element bearing design: https://doi.org/10.1016/j.future.2019.02.028
        fobj=@Design16;
        D=160;
        d=90;
        lb=[0.5*(D+d) 0.15*(D-d) 4 0.515 0.515 0.4 0.6 0.3 0.02 0.6];
        ub=[0.6*(D+d) 0.45*(D-d) 50 0.6 0.6 0.5 0.7 0.4 0.1 0.85];
        dim=length(lb);
        
    case 17 % Multiple disk clutch brake design: https://doi.org/10.1016/j.future.2019.02.028
        fobj=@Design17;
        lb=[60,90,1,0,2];
        ub=[80,110,3,1000,9];
        dim=length(lb);
        
    case 18 % Step-cone pulley problem: https://doi.org/10.1016/j.eswa.2022.116828
        fobj=@Design18;
        lb=[0,0,0,0,0];
        ub=[60,60,90,90,90];
        dim=length(lb);
        
    case 19 % Planetary gear train design optimization problem:https://doi.org/10.1016/j.ins.2022.06.008
        fobj=@Design19;
        lb=[16.51,13.51,13.51,16.51,13.51,47.51,0.51,0.51,0.51];
        ub=[96.49,54.49,51.49,46.49,51.49,124.49,3.49,6.49,6.49];
        dim=length(lb);
        
    case 20 % Robot gripper problem: 10.1016/j.cad.2010.12.015
        fobj=@Design20;
        lb=[10,10,100,0,10,100,1];
        ub=[150,150,200,50,150,300,3.14];
        dim=length(lb);
        
    case 21 %  Heat exchanger network design problem: https://doi.org/10.1016/j.eswa.2022.116828
        fobj=@Design21;
        lb=[10^4,10^4,10^4,0,0,0,100, 100, 100, 100, 100];
        ub=[10^5,1.131*10^6,2.05*10^6, 5.074e-2, 5.074e-2, 5.074e-2, 200,300, 300, 300, 400];
        dim=length(lb);
    case 22 % Heat exchanger network design problem(2) :https://doi.org/10.1016/j.swevo.2020.100693
        fobj=@Design22;
        lb=[0,0,0,0,1000,0,100,100,100];
        ub=[10,200,100,200,2e6,600,600,600,900];
        dim=length(lb);
    case 23 % Haverly's Pooling Problem:https://doi.org/10.1016/j.swevo.2020.100693
        fobj=@Design23;
        lb=[0,0,0,0,0,0,0,0,0];
        ub=[100,200,100,100,100,100,200,100,200];
        dim=length(lb);
    case 24 % Blending-Pooling-Separation problem
        fobj=@Design24;
        lb=zeros(1,38);
        ub=[90,150,90,150,90,90,150,90,90,90,150,150,90,90,150,90,150,90,150,90,1,1.2,1,1,1,0.5,1,1,0.5,0.5,0.5,1.2,0.5,1.2,1.2,0.5,1.2,1.2];
        dim=length(lb);
    case 25 % Reactor network design:https://doi.org/10.1016/j.swevo.2020.100693
        fobj=@Design25;
        lb=[0,0,0,0,0.00001,0.00001];
        ub=[1,1,1,1,16,16];
        dim=length(lb);
    case 26 % Optimal operation of alkylation unit :https://doi.org/10.1016/j.swevo.2020.100693
        fobj=@Design26;
        lb=[1000,0,2000,0,0,0,0];
        ub=[2000,100,4000,100,100,20,200];
        dim=length(lb);
        
    case 27 % Gas transmission compressor design:https://doi.org/10.1016/j.eswa.2022.116895
        fobj=@Design27;
        lb=[20,1,20,0.1];
        ub=[50,10,50,60];
        dim=length(lb);   
    case 28 % Two-reactor problem : https://doi.org/10.1016/j.swevo.2020.100693
        fobj=@Design28;
        lb=[0,0,0,0,0,0,0,0];
        ub=[100,100,100,100,100,100,1,1];
        dim=length(lb);           
        
    case 29 % industrial refrigeration system: https://doi.org/10.1016/j.eswa.2022.116828
        fobj = @Design29;
        dim = 14;
        lb = 0.001*ones(1, dim);
        ub = 5* ones(1, dim);
        
    case 30 % Himmelblau's function: https://doi.org/10.1016/j.swevo.2020.100693
        fobj= @Design30;
        dim=5;
        lb=[78,33,27,27,27];
        ub=[102,45,45,45,45];
    case 31 % SOPWM for 3-level inverters:     https://doi.org/10.1016/j.swevo.2020.100693

        fobj= @Design31;
        dim=4; % dim=floor(fmax/f1); fmax最大开关频率=200，f1基频=50
        lb=zeros(1,dim);
        ub=pi/2*ones(1,dim);
        
    case 32 % Topology optimization: https://doi.org/10.1016/j.swevo.2020.100693
        fobj= @Design32;
        dim= 30; % 可自行修改
        lb=0.5*ones(1,dim);
        ub=ones(1,dim);
end
end
% Design1 % Three bar truss design
function y = Design1(x)
punishment_factor = 10^3; %惩罚因子
l=100;
P=2;
sigma=2;
%
%
g(1)=(sqrt(2)*x(1)+x(2))/(sqrt(2)*x(1)^2+2*x(1)*x(2))*P-sigma;
g(2)=(x(2))/(sqrt(2)*x(1)^2+2*x(1)*x(2))*P-sigma;
g(3)=(1/(sqrt(2)*x(2)+x(1)))*P-sigma;
%

punishment=punishment_factor*sum(g(g>0).^2);
y=(2*sqrt(2)*x(1)+x(2))*l+punishment;
end

function y = Design2(x)
punishment_factor = 10^3; %惩罚因子
tau_max=13600;
sigma_max=30000;
G=12e6;
E=30e6;
delta_max=0.25;
L=14;
P=6000;
%
Pc=4.013*E*sqrt(x(3)^2*x(4)^6/36)/L^2*(1-x(3)/2/L*sqrt(E/4/G));
delta=4*P*L^3/E/x(3)^3/x(4);
sigma=6*P*L/x(3)^2/x(4);
J=2*(sqrt(2)*x(1)*x(2)*(x(2)^2/12+((x(1)+x(3))/2^2)));
R=sqrt(x(2)^2/4+((x(1)+x(3))/2)^2);
M=P*(L+x(2)/2);
tau2=M*R/J;
tau1=P/(sqrt(2)*x(1)*x(2));
tau=sqrt(tau1^2+2*tau1*tau2*x(2)/2/R+tau2^2);
%
g(1)=tau-tau_max;
g(2)=sigma-sigma_max;
g(3)=delta-delta_max;
g(4)=x(1)-x(4);
g(5)=P-Pc;
g(6)=0.125-x(1);
g(7)=1.10471*x(1)*2+0.04811*x(4)*x(3)*(14+5);
%

punishment=punishment_factor*sum(g(g>0).^2);
%
y=1.10471*x(1)*2+0.04811*x(4)*x(3)*(14+x(2))+punishment;
end

function y = Design3(x)
punishment_factor = 10^3; %惩罚因子
g(1)=1-x(2)^3*x(3)/71785/x(1)^4;
g(2)=(4*x(2)^2-x(1)*x(2))/12566*(x(2)*x(1)^3-x(1)^4)+1/5108/x(1)^2-1;
g(3)=1-140.45*x(1)/x(2)^2/x(3);
g(4)=(x(1)+x(2))/1.5-1;
%

punishment=punishment_factor*sum(g(g>0).^2);
%
y=(x(3)+2)*x(2)*x(1)+punishment;
end

function y = Design4(x)
punishment_factor = 10^3; %惩罚因子
g(1)=27/(x(1)*x(2)^2*x(3))-1;
g(2)=397.5/(x(1)*x(2)^2*x(3)^2)-1;
g(3)=1.93*x(4)^3/(x(2)*x(6)^4*x(3))-1;
g(4)=1.93*x(5)^3/(x(2)*x(7)^4*x(3))-1;
g(5) = sqrt(16.91*10^6+(745*x(4)/(x(2)*x(3)))^2)/(110*x(6)^3)-1;
g(6) = sqrt(157.5*10^6+(745*x(4)/(x(2)*x(3)))^2)/(85*x(7)^3)-1;
g(7) = (x(2)*x(3))/40-1;
g(8) = 5*x(2)/x(1)-1;
g(9) = x(1)/(12*x(2))-1;
g(10) = (1.5*x(6)+1.9)/x(4)-1;
g(11) =(1.1*x(7)+1.9)/x(5)-1;
%

punishment=punishment_factor*sum(g(g>0).^2);
%
y = 0.7854*x(1).*x(2).^2.*(3.3333.*x(3).^2+14.9334.*x(3)-43.0934)-1.508.*x(1).*(x(6).^2+x(7).^2)...
    +7.4777.*(x(6).^3+x(7).^3)+0.7854.*(x(4).*x(6).^2+x(5).*x(7).^2)+punishment;
end

function y=Design5(x)
punishment_factor = 10^3; %惩罚因子
g(1)=61/x(1)^3+37/x(2)^3+19/x(3)^3+7/x(4)^3+1/x(5)^3-1;
%

punishment=punishment_factor*sum(g(g>0).^2);
y=0.6224*sum(x)+punishment;
end

function y=Design6(x)
punishment_factor = 10^3; %惩罚因子
x(1) = 0.0625*round(x(1));
x(2) = 0.0625*round(x(2));
% Pressure vessel design
g(1) = -x(1)+0.0193*x(3);
g(2) = -x(2)+0.00954*x(3);
g(3) = -pi*x(3)^2*x(4)-4/3*pi*x(3)^3+1296000;
g(4) = x(4)-240;

punishment=punishment_factor*sum(g(g>0).^2);
y = 0.6224*x(1)*x(3)*x(4)+1.7781*x(2)*x(3)^2....
    +3.1661*x(1)^2*x(4)+19.84*x(1)^2*x(3)+punishment;
end
function y=Design7(x)
punishment_factor = 10^3; %惩罚因子
g(1) = 2*x(1)*x(3)+x(3)*(x(2)-2*x(4))-300;
term1 = x(3)*(x(2)-2*x(4))^3;
term2 = 2*x(1)*x(3)*(4*x(4)^2+3*x(2)*(x(2)-2*x(4)));
term3 = (x(2)-2*x(4))*x(3)^3;
term4 = 2*x(3)*x(1)^3;
g(2) = ((18*x(2)*10^4)/(term1+term2))+((15*x(1)*10^3)/(term3+term4))-56;
term1 = x(3)*(x(2)-2*x(4))^3/12; term2 = x(1)*x(4)^3/6; term3 = 2*x(1)*x(4)*((x(2)-x(4))/2)^2;
%

punishment=punishment_factor*sum(g(g>0).^2);
%
y=- 5000/(term1+term2+term3)+punishment;
end

function y=Design8(x)

x=round(x);
y=(1/6.931-(x(2)*x(3))/(x(1)*x(4)))^2;
end

function y=Design9(x)
punishment_factor = 10^3; %惩罚因子
P = 2300;        %compressive load (kg_f)
o_y = 500;       %yield stress (kg_f/cm^2)
E = 0.85e6;    % elasticity (kg_f/cm^2)
L = 300;        % length of the column (cm)

g(1)=P/(pi*x(1)*x(2)*o_y)-1;
g(2)=8*P*L^2/(pi^3*E*x(1)*x(2)*(x(1)^2+x(2)^2)-1);
g(3)=2/x(1)-1;
g(4)=x(1)/14-1;
g(5)=0.2/x(2)-1;
g(6)=x(2)/8-1;

punishment=punishment_factor*sum(g(g>0).^2);
y = 9.8*x(1)*x(2)+2*x(1)+punishment;
end

function y=Design10(x)
punishment_factor = 10^3; %惩罚因子
g(1)=-x(4)*x(2)*(0.4*x(1)+x(3)/6)+8.94*(x(1)+(abs(x(3)^2-x(2)^2))^0.5);
g(2)=-x(4)*x(2)^2*(0.2*x(1)+x(3)/12)+2.2*(8.94*(x(1)+(abs(x(3)^2-x(2)^2))^0.5))^(4/3);
g(3)=-x(4)+0.0156*x(1)+0.15;
g(4)=-x(4)+0.0156*x(3)+0.15;
g(5)=-x(4)+1.05;
g(6)=-x(3)+x(2);

punishment=punishment_factor*sum(g(g>0).^2);

y = (5.885*x(4)*(x(1)+x(3)))/(x(1)+(abs(x(3)^2-x(2)^2))^0.5)+punishment;
end

function y=Design11(x)
punishment_factor = 10^3; %惩罚因子
teta = 0.25*pi; P=1500; Q=10000; L=240; Mmax=1.8e+6;
R=abs(-x(4)*(x(4)*sin(teta)+x(1))+x(1)*(x(2)-x(4)*cos(teta)))/sqrt((x(4)-x(2))^2+x(1)^2);
F=0.25*pi*P*x(3)^2;
L2=((x(4)*sin(teta)+x(1))^2+(x(2)-x(4)*cos(teta))^2)^0.5;
L1=((x(4)-x(2))^2+x(1)^2)^0.5;
g(1)=Q*L*cos(teta)-R*F;
g(2)=Q*(L-x(4))-Mmax;
g(3)=1.2*(L2-L1)-L1;
g(4)=x(3)/2-x(2);

punishment=punishment_factor*sum(g(g>0).^2);

y = 0.25*pi*(x(3)^2)*(L2-L1)+punishment;

end


function y=Design12(x)
punishment_factor = 10^3; %惩罚因子
x(2)=round(x(2));
g(1)=x(2)/x(3)-4;
g(2)=180+(7.375*x(1)^2)/x(3)-x(1)*x(2);

punishment=punishment_factor*sum(g(g>0).^2);
y=2.9*x(1)+0.6*x(2)*x(3)+punishment;

end

function y=Design13(x)
punishment_factor = 10^3; %惩罚因子
Sec8 = [0.192 0.345];
Sec9 = [0.192 0.345];
nSec8 = numel(Sec8);
nSec9 = numel(Sec9);
x(8) = Sec8(min(floor(x(8)*nSec8+1),nSec8));
x(9) = Sec8(min(floor(x(9)*nSec9+1),nSec9));

% Subjective
g(1)=1.16-0.3717*x(2)*x(4)-0.00931*x(2)*x(10)-0.484*x(3)*x(9)+0.01343*x(6)*x(10)-1;
g(2)=46.36-9.9*x(2)-12.9*x(1)*x(8)+0.1107*x(3)*x(10)-32;
g(3)=33.86+2.95*x(3)+0.1792*x(10)-5.057*x(1)*x(2)-11*x(2)*x(8)-0.0215*x(5)*x(10)...
    -9.98*x(7)*x(8)+22*x(8)*x(9)-32;
g(4)=28.98+3.818*x(3)-4.2*x(1)*x(2)+0.0207*x(5)*x(10)+6.63*x(6)*x(9)...
    -7.7*x(7)*x(8)+0.32*x(9)*x(10)-32;
g(5) =0.261-0.0159*x(1)*x(2)-0.188*x(1)*x(8)-0.019*x(2)*x(7)+0.0144*x(3)*x(5)...
    +0.0008757*x(5)*x(10)+0.08045*x(6)*x(9)+0.00139*x(8)*x(11)+0.00001575*x(10)*x(11)-0.32;
g(6) =0.214+0.00817*x(5)-0.131*x(1)*x(8)-0.0704*x(1)*x(9)+0.03099*x(2)*x(6)-0.018*x(2)*x(7)...
    +0.0208*x(3)*x(8)+0.121*x(3)*x(9)-0.00364*x(5)*x(6)+0.0007715*x(5)*x(10)...
    -0.0005354*x(6)*x(10)+0.00121*x(8)*x(11)+0.00184*x(9)*x(10)-0.02*x(2)^2-0.32;
g(7)=0.74-0.61*x(2)-0.163*x(3)*x(8)+0.001232*x(3)*x(10)-0.166*x(7)*x(9)+0.227*x(2)^(2)-0.32;
g(8)=4.72-0.5*x(4)-0.19*x(2)*x(3)-0.0122*x(4)*x(10)+0.009325*x(6)*x(10)+0.000191*x(11)^(2)-4;
g(9)=10.58-0.674*x(1)*x(2)-1.95*x(2)*x(8)+0.02054*x(3)*x(10)...
    -0.0198*x(4)*x(10)+0.028*x(6)*x(10)-9.9;
g(10)=16.45-0.489*x(3)*x(7)-0.843*x(5)*x(6)+0.0432*x(9)*x(10)-0.0556*x(9)*x(11)...
    -0.000786*x(11)^(2);

punishment=punishment_factor*sum(g(g>0).^2);
y=1.98+4.90*x(1)+6.67*x(2)+6.98*x(3)+4.01*x(4)+1.78*x(5)+2.73*x(7)+punishment;

end

function y = Design14(x)
punishment_factor = 10^3; %惩罚因子
g(1)=x(1)+x(2)-240;
g(2)=x(3)+x(4)-300;
g(3)=x(1)+x(3)-200;
g(4)=x(2)+x(4)-200;
g(5)=300-(x(1)+x(2)+x(3)+x(4));

punishment=punishment_factor*sum(g(g>0).^2);
y=10*(24*x(1)+20.5*x(2)+17.2*x(3)+10*x(4))+punishment;

end

function y =Design15(x)
punishment_factor = 10^3; %惩罚因子
miu = x(1); Q=x(2); R=x(3); R0=x(4);
P =(log10(log10(8.122*10^6*miu+0.8))+3.55)/10.04;
Ef = 9336*Q*0.0307*(10^P-559.7);
h = ((pi*750/60)^2)*(2*pi*miu/Ef)*(R^4/4-R0^4/4);
P0=log(R/R0)*6*miu*Q/(pi*h^3);
W = (pi*P0/2)*(R-P0^2)/log(R/R0);

g(1)=1000-P0;
g(2)=W- 101000;
g(3)=5000-W/(pi*(R^2-R0^2));
g(4)=50-P0;
g(5)=0.001-0.0307*Q/(386.4*P0*pi*R*h);
g(6)=R-R0;
g(7)=h-0.001;

punishment=punishment_factor*sum(g(g>0).^2);

f= Q*P0/0.7+Ef;
y = f+punishment;


end

function y =Design16(x)
punishment_factor = 10^3; %惩罚因子
D=160;d=90;Bw=30;
Dm=x(1); Db=x(2); Z=x(3); fi=x(4); f0=x(5); KDmin=x(6); KDmax=x(7);
ep = x(8); ee=x(9); xi=x(10);
Z=round(Z);
% ri=11.033; r0=11.033; fi=ri/Db; f0=r0/Db;
T=D-d-2*Db;
phio=2*pi-acos(((((D-d)/2)-3*(T/4))^2+(D/2-T/4-Db)^2-(d/2+T/4)^2)...
    /(2*((D-d)/2-3*(T/4))*(D/2-T/4-Db)));
%
g(1)=1+phio/(2*asin(Db/Dm))-Z;
g(2)=-2*Db+KDmin*(D-d);
g(3)= -KDmax*(D-d)+2*Db;
g(4)=xi*Bw-Db;
g(5)=-Dm+0.5*(D+d);
g(6)=-(0.5+ee)*(D+d)+Dm;
g(7)=-0.5*(D-Dm-Db)+ep*Db;
g(8)=0.515-fi;
g(9)=0.515-f0;
% 惩罚项
penalty=punishment_factor*sum(g(g>0).^2);

gama=Db/Dm;
fc=37.91*((1+(1.04*((1-gama/1+gama)^1.72)*((fi*(2*f0-1)/f0*...
    (2*fi-1))^0.41))^(10/3))^-0.3)*((gama^0.3*(1-gama)^1.39)/...
    (1+gama)^(1/3))*(2*fi/(2*fi-1))^0.41;
if Db<=25.4
    f=-fc*Z^(2/3)*Db^1.8;
else
    f=-3.647*fc*Z^(2/3)*Db^1.4;
end
y=f+penalty;

end

function y =Design17(x)
punishment_factor = 10^3; %惩罚因子

% parameters
Mf = 3; Ms = 40; Iz = 55; n = 250; Tmax = 15; s = 1.5; delta = 0.5;
Vsrmax = 10; rho = 0.0000078; pmax = 1; mu = 0.6; Lmax = 30; delR = 20;
Rsr = 2/3*(x(2)^3-x(1)^3)/(x(2)^2*x(1)^2);
Vsr = pi*Rsr*n/30;
A   = pi*(x(2)^2-x(1)^2);
Prz = x(4)/A;
w   = pi*n/30;
Mh  = 2/3*mu*x(4)*x(5)*(x(2)^3-x(1)^3)/(x(2)^2-x(1)^2);
T   = Iz*w/(Mh+Mf);
%
f = pi*(x(2)^2-x(1)^2)*x(3)*(x(5)+1)*rho;
g(1) = -x(2)+x(1)+delR;
g(2) = (x(5)+1)*(x(3)+delta)-Lmax;
g(3) = Prz-pmax;
g(4) = Prz*Vsr-pmax*Vsrmax;
g(5) = Vsr-Vsrmax;
g(6) = T-Tmax;
g(7) = s*Ms-Mh;
g(8) = -T;

punishment=punishment_factor*sum(g(g>0).^2);
y=f+punishment;

end

function y =Design18(x)
punishment_factor = 10^3; %惩罚因子

d1 = x(1)*1e-3; d2 = x(2)*1e-3; d3 = x(3)*1e-3; d4 = x(4)*1e-3; w = x(5)*1e-3;
N = 350; N1 = 750; N2 = 450; N3 = 250; N4 = 150;
rho = 7200; a = 3; mu = 0.35; s = 1.75*1e6; t = 8*1e-3;
% 目标函数
f = rho*w*pi/4*(d1^2*(1+(N1/N)^2)+d2^2*(1+(N2/N)^2)+d3^2*(1+(N3/N)^2)+d4^2*(1+(N4/N)^2));
% 约束
C1 = pi*d1/2*(1+N1/N)+(N1/N-1)^2*d1^2/(4*a)+2*a;
C2 = pi*d2/2*(1+N2/N)+(N2/N-1)^2*d2^2/(4*a)+2*a;
C3 = pi*d3/2*(1+N3/N)+(N3/N-1)^2*d3^2/(4*a)+2*a;
C4 = pi*d4/2*(1+N4/N)+(N4/N-1)^2*d4^2/(4*a)+2*a;
R1 = exp(mu*(pi-2*asin((N1/N-1)*d1/(2*a))));
R2 = exp(mu*(pi-2*asin((N2/N-1)*d2/(2*a))));
R3 = exp(mu*(pi-2*asin((N3/N-1)*d3/(2*a))));
R4 = exp(mu*(pi-2*asin((N4/N-1)*d4/(2*a))));
P1 = s*t*w*(1-exp(-mu*(pi-2*asin((N1/N-1)*d1/(2*a)))))*pi*d1*N1/60;
P2 = s*t*w*(1-exp(-mu*(pi-2*asin((N2/N-1)*d2/(2*a)))))*pi*d2*N2/60;
P3 = s*t*w*(1-exp(-mu*(pi-2*asin((N3/N-1)*d3/(2*a)))))*pi*d3*N3/60;
P4 = s*t*w*(1-exp(-mu*(pi-2*asin((N4/N-1)*d4/(2*a)))))*pi*d4*N4/60;

g(1) = -R1+2;
g(2) = -R2+2;
g(3) = -R3+2;
g(4) = -R4+2;
g(5) = -P1+(0.75*745.6998);
g(6) = -P2+(0.75*745.6998);
g(7) = -P3+(0.75*745.6998);
g(8) = -P4+(0.75*745.6998);
h(1) = C1-C2;
h(2) = C1-C3;
h(3) = C1-C4;
% 罚函数
punishment=punishment_factor*(sum(g(g>0).^2) + sum(h(h~=0).^2));
y=f+punishment;

end


function y =Design19(x)
punishment_factor = 10^3; %惩罚因子

x = round(x);
P_id = [3,4,5];
m_id = [ 1.75, 2, 2.25, 2.5, 2.75, 3.0];
N1 = x(1); N2 = x(2); N3 = x(3); N4 = x(4); N5 = x(5); N6 = x(6);
p  = P_id(x(7)); m1 = m_id(x(8)); m2 = m_id(x(9));
% 目标函数
i1 = N6/N4; i01 = 3.11;
i2 = N6*(N1.*N3+N2*N4)/(N1*N3*(N6-N4)); i02 = 1.84;
iR = -(N2*N6/(N1*N3)); i0R = -3.11;
f  = max([i1-i01,i2-i02,iR-i0R],[],2);
% 约束
Dmax = 220; dlt22 = 0.5; dlt33 = 0.5; dlt55 = 0.5; dlt35 = 0.5; dlt34 = 0.5; dlt56 = 0.5;
beta = acos(((N6-N3)^2+(N4+N5)^2-(N3+N5)^2)/(2*(N6-N3)*(N4+N5)));
beta = real(beta);
g(1) = m2*(N6+2.5)-Dmax;
g(2) = m1*(N1+N2)+m1*(N2+2)-Dmax;
g(3) = m2*(N4+N5)+m2*(N5+2)-Dmax;
g(4) = abs(m1*(N1+N2)-m2*(N6-N3))-m1-m2;
g(5) = -((N1+N2)*sin(pi/p)-N2-2-dlt22);
g(6) = -((N6-N3)*sin(pi/p)-N3-2-dlt33);
g(7) = -((N4+N5)*sin(pi/p)-N5-2-dlt55);
g(8) = (N3+N5+2+dlt35)^2-((N6-N3)^2+(N4+N5)^2-2*(N6-N3)*(N4+N5)*cos(2*pi/p-beta));
g(9) = -(N6-2*N3-N4-4-2*dlt34);
g(10) = -(N6-N4-2*N5-4-2*dlt56);
h(1)  = (N6-N4)/p;
% 罚函数
punishment=punishment_factor*sum(g(g>0).^2)+punishment_factor*sum(h(rem(N6-N4,p)~=0).^2);

y=f+punishment;

end

function y =Design20(x)
punishment_factor = 10^3; %惩罚因子
a = x(1); b = x(2); c = x(3); e = x(4); ff = x(5); l = x(6); delta = x(7);
Ymin = 50; Ymax = 100; YG = 150; Zmax = 100;

% 目标函数
fhd1 = @(z) F1(x,z,2);
fhd2 = @(z) -F1(x,z,2);
options = optimset('Display','off');
[~,fit1]= fminbnd(fhd1,0,Zmax,options);
[~,fit2]= fminbnd(fhd2,0,Zmax,options);
f = -fit2-fit1;
% 约束
g(1) = -Ymin+F1(x, Zmax,1);
g(2) = -F1(x, Zmax,1);
g(3) = Ymax-F1(x, 0,1);
g(4) = F1(x, 0,1)-YG;
g(5) = l^2+e^2-(a+b)^2;
g(6) = b^2-(a-e)^2-(l-Zmax)^2;
g(7) = Zmax-l;
% 罚函数
punishment=punishment_factor*sum(g(g>0).^2);

y=f+punishment;

end

function out = F1(x,z,flag)
a = x(1); b = x(2); c = x(3); e = x(4); ff = x(5); l = x(6); delta = x(7);
P=100;
g = sqrt(e^2+(z-l)^2);
phio = atan(e/(l-z));
alpha = acos((a^2+g^2-b^2)/(2*a*g))+phio;
beta = acos((b^2+g^2-a^2)/(2*b*g))-phio;
if flag == 1
    y = 2*(ff+e+c*sin(beta+delta));
    out = real(y);
elseif flag == 2
    Fk = P*b*sin(alpha+beta)/(2*c*cos(alpha));
    out = real(Fk);
end

end


function y =Design21(x)
punishment_factor = 10^3; %惩罚因子

h(1)=x(1)-1e4*(x(7)-100);
h(2)=x(2)-1e4*(x(8)-x(7));
h(3)=x(3)-1e4*(500-x(8));
h(4)=x(1)-1e4*(300-x(9));
h(5)=x(2)-1e4*(400-x(10));
h(6)=x(3)-1e4*(600-x(11));
h(7)=x(4)*log(x(9)-100+1e-8)-x(4)*log(300-x(7))-x(9)-x(7)+400;
h(8)=x(5)*log(abs(x(10)-x(7))+1e-8)-x(5)*log(400-x(8))-x(10)+x(7)-x(8)+400;
h(9)=x(6)*log(abs(x(11)-x(8))+1e-8)-x(6)*log(100)-x(11)+x(8)+100;

f = (x(1)/(120*x(4)))^0.6+(x(2)/(80*x(5)))^0.6+(x(3)/(40*x(6)))^0.6;

punishment=punishment_factor*sum(h(h~=0).^2);

y=f+punishment;


end

function y =Design22(x)
punishment_factor = 10^3; %惩罚因子

h(1) = 200 * x(1) * x(4) - x(3);
h(2) = 200 * x(2) * x(6) - x(5);
h(3) = x(3) - 10000 * (x(7) - 100);
h(4) = x(5) - 10000 * (300 - x(7));
h(5) = x(3) - 10000 * (600 - x(8));
h(6) = x(5) - 10000 * (900 - x(9));
h(7) = x(4) * log(x(8) - 100 + 1e-8) - x(4) * log((600 - x(7)) + 1e-8) - x(8) + x(7) + 500;
h(8) = x(6) * log(x(9) - x(7) + 1e-8) - x(6) * log(600) - x(9) + x(7) + 600;
% 罚函数
punishment=punishment_factor*sum(h(h~=0).^2);

f = 35 * x(1)^0.6 + 35 * x(2)^0.6;
y=f+punishment;

end

function y =Design23(x)
punishment_factor = 10^3; %惩罚因子

g(1) = x(9) * x(7) + 2 * x(5) - 2.5 * x(1);
g(2) = x(9) * x(8) + 2 * x(6) - 1.5 * x(2);

h(1) = x(7) + x(8) - x(3) - x(4);
h(2) = x(1) - x(7) - x(5);
h(3) = x(2) - x(8) - x(6);
h(4) = x(9) * x(7) + x(9) * x(8) - 3 * x(3) - x(4);
% 罚函数
punishment=punishment_factor*(sum((h(h~=0).^2))+sum(g(g>0).^2));

f = -(9 * x(1) + 15 * x(2) - 6 * x(3) - 16 * x(4) - 10 * (x(5) + x(6)));
y=f+punishment;

end

function y =Design24(x)
punishment_factor = 10^3; %惩罚因子

g(1) = x(9) * x(7) + 2 * x(5) - 2.5 * x(1);
g(2) = x(9) * x(8) + 2 * x(6) - 1.5 * x(2);

h(1) = x(1) + x(2) + x(3) + x(4) - 300;
h(2) = x(6) - x(7) - x(8);
h(3) = x(9) - x(10) - x(11) - x(12);
h(4) = x(14) - x(15) - x(16) - x(17);
h(5) = x(18) - x(19) - x(20);
h(6) = x(5) * x(21) - x(6) * x(22) - x(9) * x(23);
h(7) = x(5) * x(24) - x(6) * x(25) - x(9) * x(26);
h(8) = x(5) * x(27) - x(6) * x(28) - x(9) * x(29);
h(9) = x(13) * x(30) - x(14) * x(31) - x(18) * x(32);
h(10) = x(13) * x(33) - x(14) * x(34) - x(18) * x(35);
h(11) = x(13) * x(36) - x(14) * x(37) - x(18) * x(37);
h(12) = 1 / 3 * x(1) + x(15) * x(31) - x(5) * x(21);
h(13) = 1 / 3 * x(1) + x(15) * x(34) - x(5) * x(24);
h(14) = 1 / 3 * x(1) + x(15) * x(37) - x(5) * x(27);
h(15) = 1 / 3 * x(2) + x(10) * x(23) - x(13) * x(30);
h(16) = 1 / 3 * x(2) + x(10) * x(26) - x(13) * x(33);
h(17) = 1 / 3 * x(2) + x(10) * x(29) - x(13) * x(36);
h(18) = 1 / 3 * x(3) + x(7) * x(22) + x(11) * x(23) + x(16) * x(31) + x(19) * x(32) - 30;
h(19) = 1 / 3 * x(3) + x(7) * x(25) + x(11) * x(26) + x(16) * x(34) + x(19) * x(35) - 50;
h(20) = 1 / 3 * x(3) + x(7) * x(28) + x(11) * x(29) + x(16) * x(37) + x(19) * x(38) - 30;
h(21) = x(21) + x(24) + x(27) - 1;
h(22) = x(22) + x(25) + x(28) - 1;
h(23) = x(23) + x(26) + x(29) - 1;
h(24) = x(30) + x(33) + x(36) - 1;
h(25) = x(31) + x(34) + x(37) - 1;
h(26) = x(32) + x(35) + x(38) - 1;
h(27) = x(25);
h(28) = x(28);
h(29) = x(23);
h(30) = x(37);
h(31) = x(32);
h(32) = x(35);
% 罚函数
punishment=punishment_factor*(sum((h(h~=0).^2))+sum(g(g>0).^2));
f = 0.9979 + 0.00432 * x(5) + 0.01517 * x(13);
y=f+punishment;

end
function y =Design25(x)
k1 = 0.09755988;
k2 = 0.99 * k1;
k3 = 0.0391908;
k4 = 0.9 * k3;
punishment_factor = 10^3; %惩罚因子
g(1) = x(5)^0.5 + x(6)^0.5 - 4;
h(1) = x(1) + k1 * x(2) * x(5) - 1;
h(2) = x(2) - x(1) + k2 * x(2) * x(6);
h(3) = x(3) + x(1) + k3 * x(3) * x(5) - 1;
h(4) = x(4) - x(3) + x(2) - x(1) + k4 * x(4) * x(6);
% 罚函数
punishment=punishment_factor*(sum((h(h~=0).^2))+sum(g(g>0).^2));
f = -x(4);
y=f+punishment;
end


function y =Design26(x)

punishment_factor = 10^3; %惩罚因子
g(1) = 0.0059553571 * x(6) ^ 2 * x(1) + 0.88392857 * x(3) - 0.1175625 * x(6) * x(1) - x(1);
g(2)  = 1.1088 * x(1) + 0.1303533 * x(1) * x(6) - 0.0066033 * x(1) * x(6) ^ 2 - x(3);
g(3)  = 6.66173269 * x(6) ^ 2 + 172.39878 * x(5) - 56.596669 * x(4) - 191.20592 * x(6) - 10000;
g(4)  = 1.08702 * x(6) + 0.32175 * x(4) - 0.03762 * x(6) ^ 2 - x(5) + 56.85075;
g(5)  = 0.006198 * x(7) * x(4) * x(3) + 2462.3121 * x(2) - 25.125634 * x(2) * x(4) - x(3) * x(4);
g(6)  = 161.18996 * x(3) * x(4) + 5000.0 * x(2) * x(4) - 489510.0 * x(2) - x(3) * x(4) * x(7);
g(7)  = 0.33 * x(7) - x(5) + 44.333333;
g(8) = 0.022556 * x(5) - 0.007595 * x(7) - 1.0;
g(9)  = 0.00061 * x(3) - 0.0005 * x(1) - 1.0;
g(10)  = 0.819672 * x(1) - x(3) + 0.819672;
g(11)  = 24500.0 * x(2) - 250.0 * x(2) * x(4) - x(3) * x(4);
g(12)  = 1020.4082 * x(4) * x(2) + 1.2244898 * x(3) * x(4) - 100000 * x(2);
g(13)  = 6.25 * x(1) * x(6) + 6.25 * x(1) - 7.625 * x(3) - 100000;
g(14)  = 1.22 * x(3) - x(6) * x(1) - x(1) + 1.0;
% 罚函数
punishment=punishment_factor*(sum(g(g>0).^2));
f = -1.715 * x(1) - 0.035 * x(1) * x(6)- 4.0565 * x(3)- 10.0 * x(2)+ 0.063 * x(3) *x(5);
y=f+punishment;
end

function y =Design27(x)

punishment_factor = 10^3; %惩罚因子
g(1) = x(4)*x(2)^(-2)+x(2)^(-2)-1;
% 罚函数
punishment=punishment_factor*(sum(g(g>0).^2));
f = 8.61e5*x(1)^0.5*x(2)*x(3)^(-2/3)*x(4)^-0.5+3.69e4*x(3)+7.72e8*x(1)^-1*x(2)^0.219-765.43e6/x(1);
y=f+punishment;
end

function y =Design28(x)
punishment_factor = 10^3; %惩罚因子
x(7) = round(x(7));
x(8) = round(x(8));
h(1) = x(7)+x(8)+1;
h(2) = x(3)-0.9*(1-exp(0.5*x(5)))*x(1);
h(3) = x(4)-0.8*(1-exp(0.4*x(6)))*x(2);
h(4) = x(3)+x(4)-10;
h(5) = x(3)*x(7)+x(4)*x(8)-10;

g(1) = x(5)-10*x(7);
g(2) = x(6)-10*x(8);
g(3) = x(1)-20*x(7);
g(4) = x(2)-20*x(8);
% 罚函数
punishment=punishment_factor*(sum(g(g>0).^2)+sum((h(h~=0).^2)));
f =7.5*x(7)+5.5*x(8)+7*x(5)+6*x(6)+5*(x(1)+x(2));
y=f+punishment;
end

function y =Design29(x)
punishment_factor = 10^3; %惩罚因子

g(1)=1.524/x(7)-1;
g(2)=1.524/x(8)-1;
g(3)=0.07789*x(1)-2*x(9)/x(7)-1;
g(4)=7.05305*x(1)^2*x(10)/(x(9)*x(8)*x(2)*x(14))-1;
g(5)=0.0833*x(14)/x(13)-1;
g(6)=47.136*x(2)^0.333*x(12)/x(10)-1.333*x(8)*x(13)^2.1195+62.08*x(13)^2.1195*x(8)^0.2/(x(12)*x(10))-1;
g(7)=0.04771*x(10)*x(8)^1.8812*x(12)^0.3424 - 1 ;
g(8)=0.0488*x(9)*x(7)^1.893*x(11)^0.316 - 1;
g(9)=0.0099*x(1)/x(3)-1;
g(10)=0.0193*x(2)/x(4)-1;
g(11)= 0.0298*x(1)/x(5)-1;
g(12)=0.056*x(2)/x(6)-1;
g(13)=2/x(9)-1;
g(14)=2/x(10)-1;
g(15)=x(12)/x(11) -1;

% 罚函数
punishment=punishment_factor*(sum(g(g>0).^2));
f =63098.88*x(2)*x(4)*x(12) + 5441.5*x(2)^2*x(12) + 115055.5*x(2)^1.664*x(6)+...
     6172.27*x(2)^2*x(6) + 63098.88*x(1)*x(3)*x(11) + 5441.5*x(1)^2*x(11)+...
     115055.5*x(1)^1.664* x(5) + 6172.27*x(1)^2*x(5) + 140.53*x(1)*x(11)+...
     281.29*x(3)*x(11) + 70.26*x(1)^2 + 281.29*x(1)*x(3) + 281.29*x(3)^2+...
     14437*x(8)^1.8812* x(12)^0.3424*x(10)*x(1)^2*x(7)/(x(14)*x(9)) +...
     20470.2*x(7)^2.893*x(11)^0.316*x(12);

y=f+punishment;
end

function y =Design30(x)
punishment_factor = 10^3; %惩罚因子

G1=85.334407 + 0.0056858*x(2)*x(5) + 0.0006262*x(1)*x(4)- 0.0022053*x(3)*x(5);
G2=80.51249 + 0.0071317*x(2)*x(5) + 0.0029955*x(1)*x(2) + 0.0021813*x(3)^2;
G3=9.300961 + 0.0047026*x(3)*x(5) + 0.00125447*x(1)*x(3) + 0.0019085*x(3)*x(4);

g(1)=-G1;
g(2)=G1-92;
g(3)=90-G2;
g(4)=G2-110;
g(5)=20-G3;
g(6)=G3-25;

% 罚函数
punishment=punishment_factor*(sum(g(g>0).^2));
f = 5.3578547*x(3)^2 + 0.8356891*x(1)*x(5) + 37.293239*x(1) - 40792.141;

y=f+punishment;
end

function y =Design31(x)

kk=primes(100); % 100以内素数
k=kk(2:end); % 去除2
for i=1:length(k)
    for j=1:length(x)
        A(j)=((-1)^(j+1)*cos(i*x(j)))^2;
    end
    B(i)=sum(A);
end

f=sqrt(sum(k.^(-4).*B))/sqrt(sum(k.^(-4)));

punishment_factor = 10^3; %惩罚因子

for i=1:length(x)-1
    g(i)=-(x(i+1)-x(i)-10^-5);
end
for i=1:length(x)
    C(i)=(-1)^(i+1)*cos(x(i));
end
h(1)=0.85-sum(C);
% 罚函数
punishment=punishment_factor*(sum(g(g>0).^2)+sum((h(h~=0).^2)));
%
y=f+punishment;
end

function y =Design32(x)
%%%%%%%%%% ELEMENT STIFFNESS MATRIX %%%%%%%
E = 1; % Damping coefficient max value
nu = 0.3; % Poisson's ratio
k=[ 1/2-nu/6   1/8+nu/8 -1/4-nu/12 -1/8+3*nu/8 ... 
   -1/4+nu/12 -1/8-nu/8  nu/6       1/8-3*nu/8];
KE = E/(1-nu^2)*[ k(1) k(2) k(3) k(4) k(5) k(6) k(7) k(8)
                  k(2) k(1) k(8) k(7) k(6) k(5) k(4) k(3)
                  k(3) k(8) k(1) k(6) k(7) k(4) k(5) k(2)
                  k(4) k(7) k(6) k(1) k(8) k(3) k(2) k(5)
                  k(5) k(6) k(7) k(8) k(1) k(2) k(3) k(4)
                  k(6) k(5) k(4) k(3) k(2) k(1) k(8) k(7)
                  k(7) k(4) k(5) k(2) k(3) k(8) k(1) k(6)
                  k(8) k(3) k(2) k(5) k(4) k(7) k(6) k(1)];
%%%%%%%%%% FE-ANALYSIS %%%%%%%%%%%%
penal=3; % Penalization factor 
[nely,nelx]=size(x);
K = sparse(2*(nelx+1)*(nely+1), 2*(nelx+1)*(nely+1));
F = sparse(2*(nely+1)*(nelx+1),1); U = zeros(2*(nely+1)*(nelx+1),1);
for elx = 1:nelx
  for ely = 1:nely
    n1 = (nely+1)*(elx-1)+ely; 
    n2 = (nely+1)* elx   +ely;
    edof = [2*n1-1; 2*n1; 2*n2-1; 2*n2; 2*n2+1; 2*n2+2; 2*n1+1; 2*n1+2];
    K(edof,edof) = K(edof,edof) + x(ely,elx)^penal*KE;
  end
end
% DEFINE LOADS AND SUPPORTS (HALF MBB-BEAM)
F(2,1) = -1;
fixeddofs   = union([1:2:2*(nely+1)],[2*(nelx+1)*(nely+1)]);
alldofs     = [1:2*(nely+1)*(nelx+1)];
freedofs    = setdiff(alldofs,fixeddofs);
% SOLVING
U(freedofs,:) = K(freedofs,freedofs) \ F(freedofs,:);
U(fixeddofs,:)= 0;
% % OBJECTIVE FUNCTION
y = 0.;
for ely = 1:nely
    for elx = 1:nelx
        n1 = (nely+1)*(elx-1)+ely;
        n2 = (nely+1)* elx   +ely;
        Ue = U([2*n1-1;2*n1; 2*n2-1;2*n2; 2*n2+1;2*n2+2; 2*n1+1;2*n1+2],1);
        y= y + x(ely,elx)^penal*Ue'*KE*Ue;
    end
end
end