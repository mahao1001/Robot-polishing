function[sys, x0, str, ts] = plant(t, x, u, flag)
switch flag
    case 0
        [sys, x0, str, ts] = mdlInitializeSizes;
    case 1
        sys = mdlDerivatives(t, x, u);
    case 3
        sys = mdlOutputs(t, x, u);
    case {2, 4, 9}
        sys = [];
    otherwise
        error(['Unhandled flag = ', num2str(flag)]);
end


function [sys, x0, str, ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates     =   12;
sizes.NumDiscStates     =   0;
sizes.NumOutputs        =   12;
sizes.NumInputs         =   6;
sizes.DirFeedthrough    =   0;
sizes.NumSampleTimes    =   1;
sys = simsizes(sizes);
x0  = [0; 0; 0; 0; 0; 0;
    0; 0; 0; 0; 0; 0];
str = [];
ts  = [0 0];


function sys = mdlDerivatives(t, x, u)
Xe = x(1); Ye = x(2); Ze = x(3);
ub = x(4); vb = x(5); wb = x(6);
phi = x(7); theta = x(8); psi = x(9);
p = x(10); q = x(11); r = x(12);

Fxe = u(1); Fye = u(2); Fze = u(3);
Mxe = u(4); Mye = u(5); Mze = u(6);
Fe = [Fxe; Fye; Fze];
Me = [Mxe; Mye; Mze];

m = 2; Inertia = eye(3);

R = xyz2R(phi, theta, psi);
[~, ~, at] = R2AT(R);
J = calJ(phi, theta, psi);

Fb = R' * Fe;
Mb = R' * Me;

Vb = [ub; vb; wb];
omega = [p; q; r];

B1 = diag([2, 2, 2]);
K1 = diag([2, 2, 2]);

B2 = diag([1, 1, 1]);
K2 = diag([1, 1, 1]);


dVb = 1 / m * (Fb - B1 * Vb - R' * K1 * [Xe; Ye; Ze]) - cross(omega, Vb) ;

dOmega = pinv(Inertia) * (Mb - cross(omega, Inertia * omega) - B2 * omega - R' * K2 * at);


sys(1:3) = R * Vb;
sys(4:6) = dVb;
sys(7:9) = J * omega;
sys(10:12) = dOmega;


function sys = mdlOutputs(t, x, u)
sys(1:3) = x(1:3);
sys(4:6) = x(4:6);
sys(7:9) = x(7:9);
sys(10:12) = x(10:12);