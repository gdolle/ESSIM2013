close all
l_A=28;
l_F=28;
l_H=18;
alfaMin=-50*pi/180;
alfaMax=90*pi/180;
betaMin=-10*pi/180;
betaMax=150*pi/180;
gammaMin=-70*pi/180;
gammaMax=80*pi/180;
areaGreen=8.0646e3;

logN=3:0.25:5.6;
N=10.^logN;
n=length(N);

t=zeros(n,1);
A_MCdA_G=zeros(n,1); 

for i=1:n
    tic
    areaMC=ArmArea(alfaMin, alfaMax, betaMin, betaMax, gammaMin, gammaMax, l_A, l_F, l_H, N(i), 0);
    t(i)=toc;
    A_MCdA_G(i)=areaMC/areaGreen;
end
figure()
semilogx(N, t)
xlabel('Number of Simulations')
ylabel('time (s)')
title('Time required for calculating the area with Monte-Carlo method')


figure()
semilogx(N,A_MCdA_G)


xlabel('Number of Simulations')
ylabel('Area_{MC}/Area_{Green}')
title('Area_{MC}/Area_{Green} as a function of the number of simulations')
