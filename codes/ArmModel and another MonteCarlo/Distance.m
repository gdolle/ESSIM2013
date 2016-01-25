function [ d ] = Distance( alfa, beta, gamma, l_A, l_F, l_H )
%Distance to the finger tip from the shouler given characteristics of the arm
%   Detailed explanation goes here
[x y]=ArmPosition(alfa, beta, gamma, l_A, l_F, l_H);
d=sqrt(x^2+y^2);


end

