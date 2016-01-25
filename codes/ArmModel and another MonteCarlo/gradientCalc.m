step=10;
alfaMin=[-50:step:-20]*pi/180;
alfaMax=[60:step:90]*pi/180;
betaMin=[-10:step:20]*pi/180;
betaMax=[120:step:150]*pi/180;
gammaMin=[-70:step:-40]*pi/180;
gammaMax=[50:step:80]*pi/180;
l_A=28;
l_F=28;
l_H=18;
N=100;

%[Amin, Amax, Bmim, Bmax, Gmin, Gmax]=ndgrid(alfaMin, alfaMax, betaMin, betaMax, gammaMin, gammaMax);
%area=@(aMin, aMax, bMin, bMax, gMin, gMax)ArmArea(aMin, aMax, bMin, bMax, gMin, gMax, l_A, l_F, l_H);
%A=area(Amin, Amax, Bmim, Bmax, Gmin, Gmax);
A=zeros(length(alfaMin),length(alfaMax),length(betaMin), length(betaMax), length(gammaMin), length(gammaMax));
for i=1:length(alfaMin)
    for j=1:length(alfaMax)
        for k=1:length(betaMin)
            for l=1:length(betaMax)
                for m=1:length(gammaMin)
                    for n=1:length(gammaMax)
                        A(i, j, k, l, m, n)=ArmArea(alfaMin(i), alfaMax(j), betaMin(k), betaMax(l), gammaMin(m), gammaMax(n), l_A, l_F ,l_H, N,1);
                    end
                end
            end
        end
    end
end

[dAlfaMin dAlfaMax dBetaMin dBetaMax dGammaMin dGammaMax]=gradient(A, step*pi/180);

