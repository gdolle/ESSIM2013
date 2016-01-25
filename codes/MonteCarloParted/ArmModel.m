close all
l_A=28;
l_F=28;
l_H=18;
n1=20;
n2=20;
n3=20; 
alfaMin=-50*pi/180;
alfaMax= 90*pi/180;
betaMin=-10*pi/180;
betaMax=150*pi/180;
gammaMin=-70*pi/180;
gammaMax=80*pi/180;
alfa=linspace(alfaMin,alfaMax,n1);
beta=linspace(betaMin,betaMax,n2);
gamma=linspace(gammaMin,gammaMax,n3);
x_H=zeros(n1*n2*n3,1);
y_H=zeros(n1*n2*n3,1);
nbr=1;
for i=1:n1
    for j=1:n2
        for k=1:n3
            [x_H(nbr) y_H(nbr)]=ArmPosition(alfa(i), beta(j), gamma(k), l_A, l_F, l_H);
            nbr=nbr+1;
        end
    end
end

plot(x_H, y_H,'.',0,0,'x')
grid on
axis square

%tau_out outer bound
alfaMin=-50*pi/180;
betaC=-10*pi/180;
gammaTest=linspace(-70,0)*pi/180;
[X1 Y1]=ArmPosition(alfaMin, betaMin, gammaTest, l_A, l_F, l_H);
hold on
plot(X1, Y1, 'r')
betaTest=linspace(betaMin, 0);
[X2 Y2]=ArmPosition(alfaMin, betaTest, 0, l_A, l_F, l_H);
plot(X2, Y2, 'r')
alfaTest=linspace(alfaMin, alfaMax);
[X3 Y3]=ArmPosition(alfaTest, 0, 0, l_A, l_F, l_H);
plot(X3, Y3, 'r')
betaTest=linspace(betaMin, betaMax);
[X4 Y4]=ArmPosition(alfaMax, betaTest, 0, l_A, l_F, l_H);
plot(X4, Y4, 'r')
gammaTest=linspace(0,gammaMax);
[X5 Y5]=ArmPosition(alfaMax, betaMax, gammaTest, l_A, l_F, l_H);
plot(X5, Y5, 'r')

%tau_in inner bound
alfaTest=linspace(alfaMax, alfaMin);
[X11 Y11]=ArmPosition(alfaTest, betaMax, gammaMax, l_A, l_F, l_H);
plot(X11, Y11, 'r')
betaTest=linspace(betaMax, betaMin);
[X22 Y22]=ArmPosition(alfaMin, betaTest, gammaMax, l_A, l_F, l_H);
plot(X22, Y22, 'r')

f=@(a) ArmPosition(alfaMin, betaMin, gammaMax, l_A, l_F, l_H)-ArmPosition(a, betaMin, gammaMin, l_A, l_F, l_H);
alfa_unknown=fsolve(f, 0)
alfaTest=linspace(alfaMin, alfa_unknown);
[X33 Y33]=ArmPosition(alfaTest, betaMin, gammaMin, l_A, l_F, l_H);
plot(X33, Y33, 'r')


offset = -10;
a1 = partition(X1,Y1,offset);
a2 = partition(X2,Y2,offset);
a3 = partition(X3,Y3,offset);
a4 = partition(X4,Y4,offset);
a5 = partition(X5,Y5,offset);

a6 = partition(X11,Y11,offset);
a7 = partition(X22,Y22,offset);
a8 = partition(X33,Y33,offset);

all_coordinates = [a1; a2; a3; a4; a5; a6; a7; a8];





montecarlo (X2,Y2,2)