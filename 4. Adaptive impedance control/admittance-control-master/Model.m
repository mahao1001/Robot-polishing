close all; clear; clc;

Alpha = [0, pi/2, 0, pi/2, -pi/2, pi/2];
A = [0, 0.05, 0.45, 0.05, 0, 0];
D = [0.40, 0, 0, 0.45, 0, 0.1];
Theta = [0, pi/2, 0, 0, 0, 0];

L(1) = Link('alpha',Alpha(1),'a', A(1),'d',D(1));L(1).offset = Theta(1); L(1).qlim=[-2 * pi, 2 * pi];L(1).mdh = 1;
L(2) = Link('alpha',Alpha(2),'a', A(2),'d', D(2));L(2).offset = Theta(2);L(2).qlim=[-2 * pi, 2 * pi];L(2).mdh = 1;
L(3) = Link('alpha',Alpha(3),'a', A(3),'d', D(3));L(3).offset = Theta(3);L(3).qlim=[-2 * pi, 2 * pi];L(3).mdh = 1;
L(4) = Link('alpha',Alpha(4),'a', A(4),'d', D(4));L(4).offset = Theta(4);L(4).qlim=[-2 * pi, 2 * pi];L(4).mdh = 1;
L(5) = Link('alpha',Alpha(5),'a', A(5),'d', D(5));L(5).offset = Theta(5);L(5).qlim=[-2 * pi, 2 * pi];L(5).mdh = 1;
L(6) = Link('alpha',Alpha(6),'a', A(6),'d', D(6));L(6).offset = Theta(6);L(6).qlim=[-2 * pi, 2 * pi];L(6).mdh = 1;

q = [0.0, 0.0, 0.0, 0.0, -pi/2, 0.0];
robot = SerialLink(L, 'name', 'robot');
teach(robot)