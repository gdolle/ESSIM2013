close all
tic
l_A=28;
l_F=28;
l_H=18;
alfaMin=-50*pi/180;
alfaMax=90*pi/180;
betaMin=-10*pi/180;
betaMax=150*pi/180;
gammaMin=-70*pi/180;
gammaMax=80*pi/180;

N=20000;

% %Change alfaMin
% alfaMinT=(-50:5:-20)*pi/180;
% 
% 
% n=length(alfaMinT);
% area=zeros(n,1);
% for i=1:n
%     area(i)=ArmArea(alfaMinT(i), alfaMax, betaMin, betaMax, gammaMin, gammaMax, l_A, l_F, l_H, N, 0);
% end
% figure()
% plot((alfaMinT*180/pi), area, '.')
% ylabel('Area (cm^2)')
% xlabel('\alpha_{min} (^o)')
% title('Area as a function of \alpha_{min}')
% save('alfaMinArea','alfaMinT','area');
% 
% %Change alfaMax
% alfaMaxT=(30:5:90)*pi/180;
% 
% n=length(alfaMaxT);
% 
% area=zeros(n,1);
% for i=1:n
%     area(i)=ArmArea(alfaMin, alfaMaxT(i), betaMin, betaMax, gammaMin, gammaMax, l_A, l_F, l_H, N, 0);
% end
% figure()
% plot((alfaMaxT*180/pi), area, '.')
% ylabel('Area (cm^2)')
% xlabel('\alpha_{max} (^o)')
% title('Area as a function of \alpha_{max}')
% save('alfaMaxArea','alfaMaxT','area');
% 
% %Change betaMin
% 
% betaMinT=(-10:5:30)*pi/180;
% 
% n=length(betaMinT);
% 
% area=zeros(n,1);
% for i=1:n
%     area(i)=ArmArea(alfaMin, alfaMax, betaMinT(i), betaMax, gammaMin, gammaMax, l_A, l_F, l_H, N, 0);
% end
% figure()
% plot(betaMinT*180/pi, area, '.')
% ylabel('Area (cm^2)')
% xlabel('\beta_{min} (^o)')
% title('Area as a function of \beta_{min}')
% save('betaMinArea2','betaMinT','area');

% %Change betaMax
% 
% betaMaxT=(50:5:150)*pi/180;
% 
% n=length(betaMaxT);
% 
% area=zeros(n,1);
% for i=1:n
%     area(i)=ArmArea(alfaMin, alfaMax, betaMin, betaMaxT(i), gammaMin, gammaMax, l_A, l_F, l_H, N, 0);
% end
% figure()
% plot(betaMaxT*180/pi, area, '.')
% ylabel('Area (cm^2)')
% xlabel('\beta_{max} (^o)')
% title('Area as a function of \beta_{max}')
% save('betaMaxArea','betaMaxT','area');
% 
% %Change gammaMin
% 
% gammaMinT=(-70:5:-20)*pi/180;
% 
% n=length(gammaMinT);
% 
% area=zeros(n,1);
% for i=1:n
%     area(i)=ArmArea(alfaMin, alfaMax, betaMin, betaMax, gammaMinT(i), gammaMax, l_A, l_F, l_H, N, 0);
% end
% figure()
% plot(gammaMinT*180/pi, area, '.')
% ylabel('Area (cm^2)')
% xlabel('\gamma_{min} (^o)')
% title('Area as a function of \gamma_{min}')
% save('gammaMinArea','gammaMinT','area');
% 
% %Change gammaMax
% 
gammaMaxT=(20:5:80)*pi/180;

n=length(gammaMaxT);

area=zeros(n,1);
for i=1:n
    area(i)=ArmArea(alfaMin, alfaMax, betaMin, betaMax, gammaMin, gammaMaxT(i), l_A, l_F, l_H, N, 0);
end
figure()
plot(gammaMaxT*180/pi, area, '.')
ylabel('Area (cm^2)')
xlabel('\gamma_{max} (^o)')
title('Area as a function of \gamma_{max}')

save('gammaMaxArea2','gammaMaxT','area');
toc