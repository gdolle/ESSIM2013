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

% t=zeros(n,1);
% A_MCdA_G=zeros(n,1); 

% for i=1:n
%     tic
%     areaMC=ArmArea(alfaMin, alfaMax, betaMin, betaMax, gammaMin, gammaMax, l_A, l_F, l_H, N(i), 0);
%     t(i)=toc;
%     A_MCdA_G(i)=areaMC/areaGreen;
% end
figure()
semilogx(N, t,'-b.','LineWidth',2,'MarkerSize',14)
xlabel('Number of points','FontSize',15)
ylabel('time (s)','FontSize',15)
title('Time required for calculating the area with Monte-Carlo method','FontSize',15)
xlim([(N(1)) (N(end))])
% ylim([0.98 1.05])
set(gca,'FontSize',15)
set(gcf,'Position',[177 104 814 556])


figure()
semilogx(N,A_MCdA_G,'-b.','LineWidth',2,'MarkerSize',14)
hold on
plot(N,ones(size(N)),'r--','LineWidth',1.5)


xlabel('Number of points','FontSize',15)
ylabel('Area_{MC}/Area_{Green}','FontSize',15)
title('Area_{MC}/Area_{Green} as a function of the number of points','FontSize',15)
xlim([(N(1)) (N(end))])
ylim([0.98 1.05])
set(gca,'FontSize',15)
set(gcf,'Position',[177 104 814 556])
