function [ d ] = DistBet( alfa1, alfa2, beta1, beta2, gamma1, gamma2, l_A, l_F, l_H )
%distance between two positions given characteristics of the arm
%   Detailed explanation goes here
[x1, y1]=ArmPosition(alfa1, beta1, gamma1, l_A, l_F, l_H);
[x2, y2]=ArmPosition(alfa2, beta2, gamma2, l_A, l_F, l_H);
d=sqrt((x1-x2)^2+(y1-y2)^2);


end

