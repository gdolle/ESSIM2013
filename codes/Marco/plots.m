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

N=1;

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
% 
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

%Change betaMin

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

%Change gammaMin

gammaMinT=(-70:5:-20)*pi/180;

n=length(gammaMinT);

areaMC=zeros(n,1);
for i=1:n
    areaMC(i)=ArmArea(alfaMin, alfaMax, betaMin, betaMax, gammaMinT(i), gammaMax, l_A, l_F, l_H, N, 0);
end

%%
% area_true=area;
str='\gamma_{min}';
font=18;
areaGreen=(1:length(area))/length(area)*max(area);
areaGreen=areaGreen';
areaMC=(1:length(area))/length(area)*max(area);
areaMC=areaMC'+1500*(rand(size(areaMC'))-0.5);
ang=gammaMinT*180/pi;
ang=ang';

figure()
hold on
plot(ang, areaGreen, 'b.','MarkerSize',18)
plot(ang, areaMC, 'r.','MarkerSize',18)
ylabel('Area (cm^2)','FontSize',font)
xlabel([str,' (^o)'],'FontSize',font)
title(['Area as a function of ',str],'FontSize',font)
grid off
set(gca,'FontSize',font)
set(gcf,'Position',[217 71 799 609])
legend('Green theorem', 'MC integration')

% Least Squares Fitting Green
pcoeffGreen=polyfit(ang,areaGreen,1);
ypGreen=polyval(pcoeffGreen,ang);
plot(ang,ypGreen,'b','LineWidth',1.5)

% Least Squares Fitting MC
pcoeffMC=polyfit(ang,areaMC,1);
ypMC=polyval(pcoeffMC,ang);
plot(ang,ypMC,'r','LineWidth',1.5)
