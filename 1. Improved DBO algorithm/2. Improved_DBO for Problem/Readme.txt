Select design problems
% 1. Three bar truss design
% 4. Speed Reducer
% 6. Pressure vessel design
% 7. I-beam vertical deflection 


The other codes are in the form of functions and cannot be run directly.

The optimization algorithm code is placed in the optimization folder, and other algorithms can be placed in it for easy management;

ProbInfo.m is the basic property of engineering optimization design problems, which stipulates the dimension of the problem, the value range of each decision variable, the mathematical model of the engineering optimization design problem, that is, the objective function, the constraints, and the process of using the penalty function;
Cal_stats.m is used to calculate 8 indicators
1. Best,
2. Worst,
3. Mean,
4. Median,
5. Standard deviation,
6. Wilcoxon's rank-sum test,
7. Wilcoxon signed-rank test,
8. Friedman test

The optimal solutions to the four engineering problems are saved in .mat and .xlsx files respectively.

The convergence curve and box plot are shown in the .fig file respectively.



