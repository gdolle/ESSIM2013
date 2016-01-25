close all
clear all
clc

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
x_W=zeros(n1*n2*n3,1);
y_W=zeros(n1*n2*n3,1);
nbr=1;
for i=1:n1
    for j=1:n2
        for k=1:n3
            [x_H(nbr), y_H(nbr), x_W(nbr), y_W(nbr)]=ArmPosition(alfa(i), beta(j), gamma(k), l_A, l_F, l_H);
            nbr=nbr+1;
        end
    end
end

figure
plot(x_H, y_H,'.',0,0,'x')
hold on
plot(x_W, y_W,'rx')
grid on
axis square

hold on
for i=1:length(x_W)
line([x_W(i) x_H(i)], [y_W(i) y_H(i)],'Color','k')
end

% return

figure
plot(x_H, y_H,'.',0,0,'x')
grid on
axis square

Xvh=[];
Yvh=[];
Nvh1=[];
Nvh2=[];

%tau_out outer bound
gammaTest=linspace(gammaMin,max([-max([betaMin,0]),gammaMin]),31);
[Xh1, Yh1, Xw1, Yw1, Xe1, Ye1]=ArmPosition(alfaMin, betaMin, gammaTest, l_A, l_F, l_H);
hold on
plot(Xh1, Yh1, 'r','LineWidth',2)
n_H1=-[-sin(alfaMin+betaMin+gammaTest); cos(alfaMin+betaMin+gammaTest)];
quiver(Xh1(1:10:end),Yh1(1:10:end),n_H1(1,1:10:end),n_H1(2,1:10:end),0.8,'k','LineWidth',2)
q1=quiver(Xh1(1:10:end),Yh1(1:10:end),n_H1(1,1:10:end),n_H1(2,1:10:end),'k');
Xvh=[Xvh Xh1(1:10:end)];
Yvh=[Yvh Yh1(1:10:end)];
Nvh1=[Nvh1 n_H1(1,1:10:end)];
Nvh2=[Nvh2 n_H1(2,1:10:end)];


betaTest=linspace(betaMin, max([betaMin,0]),10);
[Xh2, Yh2, Xw2, Yw2, Xe2, Ye2]=ArmPosition(alfaMin, betaTest, max([-max([betaMin,0]),gammaMin]), l_A, l_F, l_H);
plot(Xh2, Yh2, 'r','LineWidth',2)
n_H2=-[-sin(alfaMin+betaTest); cos(alfaMin+betaTest)];
% quiver(Xh2(1:10:end),Yh2(1:10:end),n_H2(1,1:10:end),n_H2(2,1:10:end),4.5,'k','LineWidth',2)
q2=quiver(Xh2(1:10:end),Yh2(1:10:end),n_H2(1,1:10:end),n_H2(2,1:10:end),'k');
Xvh=[Xvh Xh2(1:10:end)];
Yvh=[Yvh Yh2(1:10:end)];
Nvh1=[Nvh1 n_H2(1,1:10:end)];
Nvh2=[Nvh2 n_H2(2,1:10:end)];


alfaTest=linspace(alfaMin, alfaMax,160);
[Xh3, Yh3, Xw3, Yw3, Xe3, Ye3]=ArmPosition(alfaTest, 0, 0, l_A, l_F, l_H);
plot(Xh3, Yh3, 'r','LineWidth',2)
n_H3=-[-sin(alfaTest); cos(alfaTest)];
quiver(Xh3(1:10:end),Yh3(1:10:end),n_H3(1,1:10:end),n_H3(2,1:10:end),0.2,'k','LineWidth',2)
q3=quiver(Xh3(1:10:end),Yh3(1:10:end),n_H3(1,1:10:end),n_H3(2,1:10:end),0.2,'k');
Xvh=[Xvh Xh3(1:10:end)];
Yvh=[Yvh Yh3(1:10:end)];
Nvh1=[Nvh1 n_H3(1,1:10:end)];
Nvh2=[Nvh2 n_H3(2,1:10:end)];



betaTest=linspace(0, betaMax,100);
[Xh4, Yh4, Xw4, Yw4, Xe4, Ye4]=ArmPosition(alfaMax, betaTest, 0, l_A, l_F, l_H);
plot(Xh4, Yh4, 'r','LineWidth',2)
n_H4=-[-sin(alfaMax+betaTest); cos(alfaMax+betaTest)];
quiver(Xh4(1:10:end),Yh4(1:10:end),n_H4(1,1:10:end),n_H4(2,1:10:end),0.2,'k','LineWidth',2)
q4=quiver(Xh4(1:10:end),Yh4(1:10:end),n_H4(1,1:10:end),n_H4(2,1:10:end),0.2,'k');
Xvh=[Xvh Xh4(1:10:end)];
Yvh=[Yvh Yh4(1:10:end)];
Nvh1=[Nvh1 n_H4(1,1:10:end)];
Nvh2=[Nvh2 n_H4(2,1:10:end)];



gammaTest=linspace(0,gammaMax,31);
[Xh5, Yh5, Xw5, Yw5, Xe5, Ye5]=ArmPosition(alfaMax, betaMax, gammaTest, l_A, l_F, l_H);
plot(Xh5, Yh5, 'r','LineWidth',2)
n_H5=-[-sin(alfaMax+betaMax+gammaTest); cos(alfaMax+betaMax+gammaTest)];
quiver(Xh5(1:10:end),Yh5(1:10:end),n_H5(1,1:10:end),n_H5(2,1:10:end),0.7,'k','LineWidth',2)
q5=quiver(Xh5(1:10:end),Yh5(1:10:end),n_H5(1,1:10:end),n_H5(2,1:10:end),0.2,'k');
Xvh=[Xvh Xh5(1:10:end)];
Yvh=[Yvh Yh5(1:10:end)];
Nvh1=[Nvh1 n_H5(1,1:10:end)];
Nvh2=[Nvh2 n_H5(2,1:10:end)];


%tau_in inner bound
alfaTest=linspace(alfaMax, alfaMin,11);
[Xh6, Yh6, Xw6, Yw6, Xe6, Ye6]=ArmPosition(alfaTest, betaMax, gammaMax, l_A, l_F, l_H);
plot(Xh6, Yh6, 'r','LineWidth',2)
n_H6=[-l_A*sin(alfaTest)-l_F*sin(alfaTest+betaMax)-l_H*sin(alfaTest+betaMax+gammaMax); ...
    l_A*cos(alfaTest)+l_F*cos(alfaTest+betaMax)+l_H*cos(alfaTest+betaMax+gammaMax)];
quiver(Xh6(1:10:end),Yh6(1:10:end),n_H6(1,1:10:end),n_H6(2,1:10:end),0.6,'k','LineWidth',2)
q6=quiver(Xh6(1:10:end),Yh6(1:10:end),n_H6(1,1:10:end),n_H6(2,1:10:end),0.2,'k');
Xvh=[Xvh Xh6(1:10:end)];
Yvh=[Yvh Yh6(1:10:end)];
Nvh1=[Nvh1 n_H6(1,1:10:end)];
Nvh2=[Nvh2 n_H6(2,1:10:end)];



betaTest=linspace(betaMax, betaMin,101);
[Xh7, Yh7, Xw7, Yw7, Xe7, Ye7]=ArmPosition(alfaMin, betaTest, gammaMax, l_A, l_F, l_H);
plot(Xh7, Yh7, 'r','LineWidth',2)
n_H7=[-l_F*sin(alfaMin+betaTest)-l_H*sin(alfaMin+betaTest+gammaMax); ...
    l_F*cos(alfaMin+betaTest)+l_H*cos(alfaMin+betaTest+gammaMax)];
quiver(Xh7(1:10:end),Yh7(1:10:end),n_H7(1,1:10:end),n_H7(2,1:10:end),0.25,'k','LineWidth',2)
q7=quiver(Xh7(1:10:end),Yh7(1:10:end),n_H7(1,1:10:end),n_H7(2,1:10:end),0.2,'k');
Xvh=[Xvh Xh7(1:10:end)];
Yvh=[Yvh Yh7(1:10:end)];
Nvh1=[Nvh1 n_H7(1,1:10:end)];
Nvh2=[Nvh2 n_H7(2,1:10:end)];


f=@(a) ArmPosition(alfaMin, betaMin, gammaMax, l_A, l_F, l_H)-ArmPosition(a, betaMin, gammaMin, l_A, l_F, l_H);
[alfa_unknown, ee, eee]=fsolve(f, 0);
alfaTest=linspace(alfaMin, alfa_unknown,40);
[Xh8, Yh8, Xw8, Yw8, Xe8, Ye8]=ArmPosition(alfaTest, betaMin, gammaMin, l_A, l_F, l_H);
plot(Xh8, Yh8, 'r','LineWidth',2)
n_H8=[-l_A*sin(alfaTest)-l_F*sin(alfaTest+betaMin)-l_H*sin(alfaTest+betaMin+gammaMin); ...
    l_A*cos(alfaTest)+l_F*cos(alfaTest+betaMin)+l_H*cos(alfaTest+betaMin+gammaMin)];
quiver(Xh8(1:10:end),Yh8(1:10:end),n_H8(1,1:10:end),n_H8(2,1:10:end),0.5,'k','LineWidth',2)
Xvh=[Xvh Xh8(1:10:end)];
q8=quiver(Xh8(1:10:end),Yh8(1:10:end),n_H8(1,1:10:end),n_H8(2,1:10:end),0.2,'k');
Yvh=[Yvh Yh8(1:10:end)];
Nvh1=[Nvh1 n_H8(1,1:10:end)];
Nvh2=[Nvh2 n_H8(2,1:10:end)];

set(gca,'FontSize',18)

title('Normal vectors','fontsize',15)
xlabel('Horizontal distance from the shoulder','fontsize',15)
ylabel('Vertical distance from the shoulder','fontsize',15)


return

% n_H8=[-l_H*sin(alfaMin+betaMin+gammaTest); ...
%     l_H*cos(alfaMin+betaMin+gammaTest)];
% quiver(X(1:10:end),Y(1:10:end),n_H8(1,1:10:end),n_H8(2,1:10:end),0.2,'k')
% 


sz=[length(Xh1),length(Xh2),length(Xh3),length(Xh4),length(Xh5),length(Xh6),length(Xh7),length(Xh8)];
Xh=[Xh1 Xh2 Xh3 Xh4 Xh5 Xh6 Xh7 fliplr(Xh8)];
Yh=[Yh1 Yh2 Yh3 Yh4 Yh5 Yh6 Yh7 fliplr(Yh8)];
Xw=[Xw1*ones(1,sz(1)) Xw2 Xw3 Xw4 Xw5*ones(1,sz(5)) Xw6 Xw7 fliplr(Xw8)];
Yw=[Yw1*ones(1,sz(1)) Yw2 Yw3 Yw4 Yw5*ones(1,sz(5)) Yw6 Yw7 fliplr(Yw8)];
Xe=[Xe1*ones(1,sz(1)) Xe2*ones(1,sz(2)) Xe3 Xe4*ones(1,sz(4)) Xe5*ones(1,sz(5)) Xe6 Xe7*ones(1,sz(7)) fliplr(Xe8)];
Ye=[Ye1*ones(1,sz(1)) Ye2*ones(1,sz(2)) Ye3 Ye4*ones(1,sz(4)) Ye5*ones(1,sz(5)) Ye6 Ye7*ones(1,sz(7)) fliplr(Ye8)];

stop=sz;

figure(500)
for i=1:length(Xh)
        figure(500)
        clf
        plot(Xh(1:i),Yh(1:i))
        hold on
        plot(Xh(i),Yh(i),'r.','MarkerSize',14)
        plot(0,0,'k.','MarkerSize',14)
        line([Xh(i),Xw(i)],[Yh(i),Yw(i)],'Color','b')
        line([Xw(i),Xe(i)],[Yw(i),Ye(i)],'Color','g')
        line([Xe(i),0],[Ye(i),0],'Color','k')
        axis([-80    80   -80    60])
        drawnow
        if ~isempty(find(cumsum(sz)-i==0))
            pause(0.5)
        end
end


% qscale = 0.1 ; % scaling factor for all vectors
% hU = get(q1,'UData') ;
% hV = get(q1,'VData') ;
% set(q1,'UData',qscale*hU,'VData',qscale*hV)
% 
% hU = get(q2,'UData') ;
% hV = get(q2,'VData') ;
% set(q2,'UData',qscale*hU,'VData',qscale*hV) 
% 
% hU = get(q3,'UData') ;
% hV = get(q3,'VData') ;
% set(q3,'UData',qscale*hU,'VData',qscale*hV) 
% 
% hU = get(q4,'UData') ;
% hV = get(q4,'VData') ;
% set(q4,'UData',qscale*hU,'VData',qscale*hV) 
% 
% hU = get(q5,'UData') ;
% hV = get(q5,'VData') ;
% set(q5,'UData',qscale*hU,'VData',qscale*hV) 
% 
% hU = get(q6,'UData') ;
% hV = get(q6,'VData') ;
% set(q6,'UData',qscale*hU,'VData',qscale*hV) 
% 
% 
% hU = get(q7,'UData') ;
% hV = get(q7,'VData') ;
% set(q7,'UData',qscale*hU,'VData',qscale*hV) 
% 
% 
% hU = get(q8,'UData') ;
% hV = get(q8,'VData') ;
% set(q8,'UData',qscale*hU,'VData',qscale*hV) 