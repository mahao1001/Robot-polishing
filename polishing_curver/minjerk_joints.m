clear;clc

robot = loadrobot("kinovaGen3","DataFormat","row");
env = {collisionBox(2,2,0.01) collisionSphere(0.1) collisionCylinder(0.1,0.5)};
env{1}.Pose(3,end) = -0.05;
env{2}.Pose(1:3,end) = [0.4 0.4 -0.4];
env{3}.Pose(1:3,end) = [-0.5 0.3 0.20];

show(robot);
hold on
show(env{1})
show(env{2})
show(env{3})

rrt = manipulatorRRT(robot,env);
rrt.ValidationDistance = 0.2;
rrt.SkippedSelfCollisions = "parent";


startConfig = [0.0133780625460094	-0.593864719621418	-0.478570801397258	-3.17427691233028e-07	1.07243544105223	0.0133784414418741   0];
goalConfig = [0.924070636206967	0.127182400896507	-1.13537639764365	4.39969920125893e-08	1.00819396302552	0.924070566203372  0];
% startConfig = [0.08 -0.65 0.05 0.02 0.04 0.49 0.04];
% goalConfig =  [2.97 -1.05 0.05 0.02 0.04 0.49 0.04];


rng(0)
path = plan(rrt,startConfig,goalConfig);

interpPath = interpolate(rrt,path);
wpts = interpPath';

initialGuess = linspace(0,size(wpts,2)*0.2,size(wpts,2));

numSamples = 50;

[q,qd,qdd,qddd,pp,tpts,tSamples] = minjerkpolytraj(wpts,initialGuess,numSamples);

minJerkPath = q';
figure
plot(tSamples,q)
hold all
plot(tpts,wpts,"x")
xlabel('Index of path point');
ylabel('Joint angle value (rad)');
% title('');
legend('Joint1','Joint2','Joint3','Joint4','Joint5','Joint6','Joint7')



figure;
ax = show(robot,startConfig);
hold all

% Ensure the figure pops out of the Live Editor so animations are visible
set(gcf,"Visible","on");
for i = 1:length(env)
    show(env{i},"Parent",ax);
end

for i = 1:size(minJerkPath,1)
    show(robot,minJerkPath(i,:),"PreservePlot",false,"FastUpdate",true);
    drawnow;
   
end


hold off
