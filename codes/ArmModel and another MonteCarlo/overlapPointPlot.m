close all
l_A=28;
l_F=28;
l_H=18;
n1=50;
n2=50;
n3=50; 
alfaMin=-50*pi/180;
alfaMax=90*pi/180;
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

plot(x_H, y_H,'g.',0,0,'o')
grid on
hold on
title('Points that can be reached with the fingertip','fontsize',12)
xlabel('Horizontal distance from the shoulder','fontsize',12)
ylabel('Vertical distance from the shoulder','fontsize',12)
axis square

alfaMin=-50*pi/180;
alfaMax=90*pi/180;
betaMin=5*pi/180;
betaMax=110*pi/180;
gammaMin=-60*pi/180;
gammaMax=50*pi/180;
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

plot(x_H, y_H,'b.')

legend('Full mobility', 'Shoulder', 'Reduced mobility')
axis square
