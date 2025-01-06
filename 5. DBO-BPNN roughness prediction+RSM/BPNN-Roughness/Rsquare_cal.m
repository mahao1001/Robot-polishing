function rsquare=Rsquare_cal(Yo,Yp)
%calculates the R-square between surrogate response and true
%function value
%--------------------------------------------------------------------------
%
%Input:
%Yo - observed function values
%Yp -predicted function values
%Output:
%rsquare
%--------------------------------------------------------------------------

sse=sum((Yo-Yp).^2);
sst=sum((Yo-mean(Yo)).^2);
rsquare=abs(1-sse/sst);

end %function