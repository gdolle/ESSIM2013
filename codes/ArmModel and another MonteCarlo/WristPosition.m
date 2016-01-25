function [ x_W, y_W ] = WristPosition(alfa, beta, l_A, l_F)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
x_E=l_A*sin(alfa);
y_E=-l_A*cos(alfa);
x_W=x_E+l_F*sin(alfa+beta);
y_W=y_E-l_F*cos(alfa+beta);
end