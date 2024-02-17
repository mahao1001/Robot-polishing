clear;clc
load('curver_polishing.mat');

% for i=1:100
% 
%     curve(i) =exp(DBO_curve(i)) ;
% 
% end

semilogy(curve,'Color','r');
% title('Objective space')
xlabel('Iteration');
ylabel('Average of 10 best scores');
%axis tight
grid on
box on
legend('DBO algorithm')


Frv = [21.3635  109.7714  6125.1699];
SRe = 20 ;

h = (10^0.03560)*((Frv(1))^0.6158)*((Frv(2))^0.4087)/( (SRe^0.4650)*((Frv(3))^0.1035))
hi= 100*(((Frv(1)^0.6666))*(Frv(2))) / (((SRe)^0.3333*(Frv(3)))) 
u = (SRe)/(Frv(1)*Frv(2))