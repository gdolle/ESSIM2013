close all
testNbr=5;
alfaMin=[-50 -10 -50 -30 -50]*pi/180;
alfaMax=[90 70 90 50 90]*pi/180;
betaMin=[-10 -10 0 -10 10]*pi/180;
betaMax=[150 150 100 150 150]*pi/180;
gammaMin=[-70 -70 -70 -70 -70]*pi/180;
gammaMax=[80 80 80 80 80]*pi/180;
l_A=28;
l_F=28;
l_H=18;
AreaMC=zeros(testNbr, 1);
AreaAn=zeros(testNbr, 1);
N=1000;
for i=1:testNbr
    AreaMC(i)=ArmArea( alfaMin(i), alfaMax(i), betaMin(i), betaMax(i), gammaMin(i), gammaMax(i), l_A, l_F, l_H, N , 1);
end
[AreaMC AreaAn]
    