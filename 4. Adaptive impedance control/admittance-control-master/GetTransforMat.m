function [R, P] = GetTransforMat(alpha, a, d, theta, q)
theta = theta + q;
T = [cos(theta), -sin(theta), 0, a;
    sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -d*sin(alpha);
    sin(theta)*sin(alpha), cos(theta)*sin(alpha), cos(alpha), d*cos(alpha);
    0, 0, 0, 1];
R = T(1:3, 1:3);
P = T(1:3, 4);