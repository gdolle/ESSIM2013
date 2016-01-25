function [ error ] = find_ab( ab,alfaMin, betaMin, gammaMax, gammaMin, l_A, l_F, l_H )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[x1 y1]=ArmPosition(alfaMin, betaMin, gammaMax, l_A, l_F, l_H);
[x2 y2]=ArmPosition(ab(1), ab(2), gammaMin, l_A, l_F, l_H);
error=sqrt((x1-x2)^2+(y1-y2)^2);