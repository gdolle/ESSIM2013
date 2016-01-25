function [ error ] = find_ag( ag,alfaMin, betaMin, gammaMax, gammaMin, l_A, l_F, l_H )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[x1 y1]=ArmPosition(alfaMin, betaMin, ag(2), l_A, l_F, l_H);
[x2 y2]=ArmPosition(ag(1), betaMin, gammaMin, l_A, l_F, l_H);
error=sqrt((x1-x2)^2+(y1-y2)^2);