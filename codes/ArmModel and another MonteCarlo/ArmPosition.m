function [ x_H, y_H ] = ArmPosition(alfa, beta, gamma, l_A, l_F, l_H )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
x_E=l_A*sin(alfa);
y_E=-l_A*cos(alfa);
x_W=x_E+l_F*sin(alfa+beta);
y_W=y_E-l_F*cos(alfa+beta);
x_H=x_W+l_H*sin(alfa+beta+gamma);
y_H=y_W-l_H*cos(alfa+beta+gamma);
end


