close all
clear all
clc

% function []=test_arm_hope(a)
%gammaMin can be > 0
%same holds for betaMin, alfaMin

% beta interval fixed, gamma interval fixed, alfaMin < x1, alfaMax > x2

close all
l_A=28;
l_F=28;
l_H=12
n1=20;
n2=20;
n3=20; 
nlin=20;
%
% alfaMax = a*pi/180;
%
alfaMin=-50*pi/180;
alfaMax= 90*pi/180;
betaMin=-10*pi/180;
betaMax=150*pi/180; %always assumed to be > 0
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
            [x_H(nbr), y_H(nbr)]=ArmPosition(alfa(i), beta(j), gamma(k), l_A, l_F, l_H);
            nbr=nbr+1;
        end
    end
end

plot(x_H, y_H,'.',0,0,'x')
grid on
axis square

%tau_out outer bound

idx=1;
Xh={};
Yh={};
Xw={};
Yw={};
Xe={};
Ye={};
ang={};
lower_bound={};
upper_bound={};

if betaMin > 0
    if gammaMax < -betaMin
        gamma1 = gammaMax;
    elseif gammaMin > -betaMin
        gamma1 = gammaMin;
    else
        gamma1 = -betaMin;
    end
else
    if gammaMax < 0
        gamma1 = gammaMax;
    elseif gammaMin > 0
        gamma1 = gammaMin;
    else
        gamma1 = 0;
    end
end

hold on
gammaTest=linspace(gammaMin,gamma1,nlin/4);
[Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaMin, betaMin, gammaTest, l_A, l_F, l_H);
plot(Xh{idx}, Yh{idx}, 'r')
lower_bound{idx}=gammaMin;
upper_bound{idx}=gamma1;
ang{idx}='gamma';
idx=idx+1;


%Final position of 2nd movement
beta2 = max([betaMin,0]);

hold on

options=optimset('Algorithm','interior-point');
out=fmincon(@(x) L2(x,alfaMin,l_A,l_F,l_H),[beta2,gamma1],[],[],[],[],[betaMin,gammaMin],[betaMax,gammaMax],[],options);
beta2=out(1);
gamma1=out(2);

betaTest=linspace(betaMin, beta2,nlin/4);
[Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaMin, betaTest, gamma1, l_A, l_F, l_H);
plot(Xh{idx}, Yh{idx}, 'r')
lower_bound{idx}=betaMin;
upper_bound{idx}=beta2;
ang{idx}='beta';
idx=idx+1;


alfaTest=linspace(alfaMin, alfaMax, nlin*2);
[Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaTest, beta2,gamma1 , l_A, l_F, l_H);
plot(Xh{idx}, Yh{idx}, 'g')
lower_bound{idx}=alfaMin;
upper_bound{idx}=alfaMax;
ang{idx}='alfa';
idx=idx+1;


% Needed?
% gamma4 = min([gammaMax,0]);
% gammaTest=linspace(gamma1,gamma4);
% [X3b Y3b]=ArmPosition(alfaMax, beta2, gammaTest, l_A, l_F, l_H);
% plot(X3b,Y3b,'b')


betaTest=linspace(beta2, betaMax, nlin);
[Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaMax, betaTest, gamma1, l_A, l_F, l_H);
plot(Xh{idx}, Yh{idx}, 'k')
lower_bound{idx}=beta2;
upper_bound{idx}=betaMax;
ang{idx}='beta';
idx=idx+1;

gammaTest=linspace(gamma1,gammaMax, nlin);
[Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaMax, betaMax, gammaTest, l_A, l_F, l_H);
plot(Xh{idx}, Yh{idx}, 'r')
lower_bound{idx}=gamma1;
upper_bound{idx}=gammaMax;
ang{idx}='gamma';
idx=idx+1;

%tau_in inner bound

alfaTest=linspace(alfaMax, alfaMin, nlin);
[Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaTest, betaMax, gammaMax, l_A, l_F, l_H);
plot(Xh{idx}, Yh{idx}, 'm')
lower_bound{idx}=alfaMax;
upper_bound{idx}=alfaMin;
ang{idx}='alfa';
idx=idx+1;

% betaTest=linspace(betaMax, betaMin, nlin);
% [Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaMin, betaTest, gammaMax, l_A, l_F, l_H);
% plot(Xh{idx}, Yh{idx}, 'k')
% lower_bound{idx}=betaMax;
% upper_bound{idx}=betaMin;
% ang{idx}='beta';
% idx=idx+1;

%%%%%%%%%%%%%

if abs(gammaMin) > abs(gammaMax)
    gamma7 = gammaMin;
else
    gamma7 = gammaMax;
end

% gammaTest=linspace(gammaMax,gamma7, nlin);
% [Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaMin, betaMax, gammaTest, l_A, l_F, l_H);
% plot(Xh{idx}, Yh{idx}, 'g')
% lower_bound{idx}=gammaMax;
% upper_bound{idx}=gamma7;
% idx=idx+1;

betaTest=linspace(betaMax, betaMin, nlin);
[Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaMin, betaTest, gamma7, l_A, l_F, l_H);
plot(Xh{idx}, Yh{idx}, 'b')
lower_bound{idx}=betaMax;
upper_bound{idx}=betaMin;
ang{idx}='beta';
idx=idx+1;

f=@(a) ArmPosition(alfaMin, betaMin, gammaMax, l_A, l_F, l_H)-ArmPosition(a, betaMin, gammaMin, l_A, l_F, l_H);
alfa_unknown=fsolve(f, 0)

alfaTest=linspace(alfa_unknown, alfaMin, nlin);
[Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaTest, betaMin, gammaMin, l_A, l_F, l_H);
plot(Xh{idx}, Yh{idx}, 'r')
lower_bound{idx}=alfa_unknown;
upper_bound{idx}=alfaMin;
ang{idx}='alfa';
idx=idx+1;

% betaTest=linspace(betaMax, betaMin, nlin);
% [Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaMin, betaTest, gammaMin, l_A, l_F, l_H);
% plot(Xh{idx}, Yh{idx}, 'm')
% lower_bound{idx}=betaMax;
% upper_bound{idx}=betaMin;
% ang{idx}='beta';
% idx=idx+1;


% gammaTest=linspace(gammaMax,gammaMin, nlin);
% [Xh{idx}, Yh{idx}, Xw{idx}, Yw{idx}, Xe{idx}, Ye{idx}]=ArmPosition(alfaMin,betaMin,gammaTest,l_A,l_F,l_H);
% plot(Xh{idx}, Yh{idx}, 'g')
% lower_bound{idx}=gammaMax;
% upper_bound{idx}=gammaMin;
% ang{idx}='gamma';
% idx=idx+1;

% gammaTest=linspace(gammaMax,gammaMin, nlin);
% [X33 Y33]=ArmPosition(alfaMin,betaMin,gammaTest,l_A,l_F,l_H);
% plot(X33,Y33, 'r')






% offset = -10;
% a1 = partition(X1,Y1,offset);
% a2 = partition(X2,Y2,offset);
% a3 = partition(X3,Y3,offset);
% a4 = partition(X4,Y4,offset);
% a5 = partition(X5,Y5,offset);
% 
% a6 = partition(X11,Y11,offset);
% a7 = partition(X22,Y22,offset);
% a8 = partition(X33,Y33,offset);
% 
% all_coordinates = [a1; a2; a3; a4; a5; a6; a7; a8];
% 
% 
% 
% 
% 
% montecarlo (X2,Y2,2)
Xhand=[];
Yhand=[];
Xwrist=[];
Ywrist=[];
Xelbow=[];
Yelbow=[];
sz=[];

for i=1:length(Xh)
    Xhand=[Xhand Xh{i}];
    Yhand=[Yhand Yh{i}];
    Xwrist=[Xwrist Xw{i}.*ones(size(Xh{i}))];
    Ywrist=[Ywrist Yw{i}.*ones(size(Xh{i}))];
    Xelbow=[Xelbow Xe{i}.*ones(size(Xh{i}))];
    Yelbow=[Yelbow Ye{i}.*ones(size(Xh{i}))];
    sz=[sz length(Xh{i})];
end

figure(500)
ii=1;
for i=1:length(Xhand)
        figure(500)
        clf
        plot(Xhand(1:i),Yhand(1:i),'LineWidth',2)
        hold on
        plot(Xhand(i),Yhand(i),'r.','MarkerSize',22)
        plot(Xwrist(i),Ywrist(i),'g.','MarkerSize',15)
        plot(Xelbow(i),Yelbow(i),'k.','MarkerSize',15)
        plot(0,0,'k.','MarkerSize',14)
        line([Xhand(i),Xwrist(i)],[Yhand(i),Ywrist(i)],'Color','r','LineWidth',2)
        line([Xwrist(i),Xelbow(i)],[Ywrist(i),Yelbow(i)],'Color','g','LineWidth',2)
        line([Xelbow(i),0],[Yelbow(i),0],'Color','k','LineWidth',2)
        axis([-80    80   -80    60])
        axis square
        set(gca,'FontSize',16)
        set(gcf,'Position',[ 1 41 1366 651])
        
        pos=find(cumsum(sz)-i>0,1);
        if isempty(pos)
            str='';
        else
            str=ang{find(cumsum(sz)-i>0,1)};
        end
        if strcmp(str,'alfa')
              text(-65,40,'Shoulder','Fontsize',35,'Color','k')
        elseif strcmp(str,'beta')
              text(-65,40,'Elbow','Fontsize',35,'Color','g')
        else
              text(-65,40,'Wrist','Fontsize',35,'Color','r')
        end
        
        
        V(ii) = getframe;
        ii=ii+1;
 
        if ~isempty(find(cumsum(sz)-i==0))
%             export_fig(500,num2str(i),'-transparent','-pdf')
            pause(0.5)
            for kk=1:8
                V(ii) = getframe;
                ii=ii+1;
            end
        end
        
        drawnow
end


% fps=8;
% % mov=movie(1,V,numtimes,fps);
% movie2avi(V, 'movie','FPS',fps,'quality',100);
% % movie(V);
