clear;clc
load('joint_qddd.mat')
tSamples = 1:50;

q = q(1:6,:);
qd = qd(1:6,:);
qdd = qdd(1:6,:);
qddd = qddd(1:6,:);

figure
plot(tSamples,q,'-x','MarkerIndices',1:10:length(q))
xlabel('Index of waypoints');
ylabel('Joint angle value (rad)');
% title('');
legend('Joint1','Joint2','Joint3','Joint4','Joint5','Joint6')


figure
plot(tSamples,qd,'-x','MarkerIndices',1:10:length(qd))
xlabel('Index of waypoints');
ylabel('Joint angular velocity value (rad/s)');
% title('');
legend('Joint1','Joint2','Joint3','Joint4','Joint5','Joint6')
hold off

figure
plot(tSamples,qdd,'-x','MarkerIndices',1:10:length(qdd))
xlabel('Index of waypoints');
ylabel('Joint angular acceleration value (rad/s^2)');
% title('');
legend('Joint1','Joint2','Joint3','Joint4','Joint5','Joint6')
hold off

figure
plot(tSamples,qddd,'-x','MarkerIndices',1:10:length(qddd))
xlabel('Index of waypoints');
ylabel('Joint angular jerk value (rad/s^3)');
% title('');
legend('Joint1','Joint2','Joint3','Joint4','Joint5','Joint6')
hold off

