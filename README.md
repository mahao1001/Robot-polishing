# Robot-polishing
Adaptive Force-Position-Speed Collaborative Process Planning and Roughness Prediction for Robotic Polishing

This study proposes an adaptive robotic polishing force-position-speed collaborative process planning framework. The improved dung beetle optimization algorithm, back propagation neural network, finite element analysis and response surface method provide a strong guarantee for the selection of robotic polishing process parameters. The adaptive impedance control strategy is implemented to enhance force control, and PD iteration and RBF neural network are used to ensure stable contact force and accuracy.

It contains a total of 6 parts：

1.	Improved DBO algorithm
This part is mainly about the improvement of DBO algorithm. The author has tried to solve various engineering problems using the improved DBO algorithm and achieved good results. This paper does not provide a detailed description of the strategy for further improvement of DBO algorithm. Please refer to the author's other papers.
The document shares the improved DBO algorithm for solving robot inverse kinematics, four engineering problems, and optimization solutions related to this study. Its superiority compared to multiple algorithms is evaluated.

2.	Curvature adaptive trajectory
This part of the paper presents the curvature adaptive interpolation algorithm. A surface example is solved and the results are obtained.

3.	Finite Element Analysis (FEA)
The source files of the finite element analysis robot and polishing require 58.9G of storage, so only the results are uploaded.

4.	Adaptive impedance control
This document is the Matlab simulation and control results of the robot's adaptive impedance control, providing a theoretical basis for controlling robot polishing. Includes impedance control, dynamic parameters, LuGre friction estimation, etc.

5.	DBO-BPNN roughness prediction+RSM
This section includes the source code and results of BPNN model and response surface analysis.

6.	Robot polishing experiments
This section presents the scenario of the robotic polishing experiment and the obtained results.
