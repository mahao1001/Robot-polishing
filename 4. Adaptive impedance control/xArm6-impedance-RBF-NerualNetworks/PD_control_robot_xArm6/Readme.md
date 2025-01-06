PD control Simulink robot arm

Continue to optimize PD parameters based on PD control

1. Three files required for the robot model:
RUDF % robot model folder
DOF6_xArm.slx % Simulink modeling
loadrobot.m % load the robot into the workspace
Only with the above can the robot model in Simulink be called

2. PD parameters in Simulink
The optimization target is IAE, absolute error and.
Variable PD value: [0,0] - [200,200]
dim = 2;
Number of populations = 30;
Maximum number of iterations = 10 times;
Just loop calculation

3. Drawing comparison

4. PD control, it is better to integrate a fuzzy control