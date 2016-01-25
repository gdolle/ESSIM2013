function [ error ] = find_abg( abg,alfaMin, betaMin, gammaMax, gammaMin, l_A, l_F, l_H )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[x1 y1]=ArmPosition(alfaMin, betaMin, abg(3), l_A, l_F, l_H);
[x2 y2]=ArmPosition(abg(1), abg(2), gammaMin, l_A, l_F, l_H);
%[x3 y3]=ArmPosition(alfaMin, betaMin, abg(3), l_A, l_F, l_H);
%[x4 y4]=ArmPosition(abg(1), betaMin, gammaMin, l_A, l_F, l_H);
error=sqrt((x1-x2)^2+(y1-y2)^2);%+sqrt((x3-x4)^2+(y3-y4)^2);