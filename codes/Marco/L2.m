function [ z] = L2(x,a,l_A,l_F,l_H)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% a=x(1);
b=x(1);
g=x(2);

z=2*l_A*l_F*sin(a)*sin(a+b)+2*l_F*l_H*sin(a+b)*sin(a+b+g)+2*l_A*l_H*sin(a)*sin(a+b+g)+...
    2*l_A*l_F*cos(a)*cos(a+b)+2*l_F*l_H*cos(a+b)*cos(a+b+g)+2*l_A*l_H*cos(a)*cos(a+b+g);
z=-z;
end