function fobj = polishing_Function(Frv)
% clear;clc;
    % Frv = [20 2000 10000];
    SRe = 20;
    fobja = 0;
    fobjt=0;

    for t = 0:0.2:2*pi
        Re = 10 * sin(t) + 10;
    
        h = (10^0.3560)*((Frv(1))^0.02158)*((Frv(2))^0.1087)/( (SRe^0.4650)*((Frv(3))^0.1035)) ;   % 求这个位差最小
        hi =(((Frv(1)^0.7778))*(Frv(2))) / (((Re)^0.3333*(Frv(3)))) ;
        fobja =fobja+ (h-hi)^2 ;

        fobjt= fobjt+ (Re^0.03333)/(Frv(1)^0.6666*Frv(2)) ;
        fobj = fobjt+fobja;
    end
   
 end


