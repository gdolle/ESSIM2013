%works when alfa_max-alfaMin>35,  betaMax-betaMin>=60 gammaMin<=0,
%gammaMax>=0 %Always look at picture!
close all
tic
l_A=28;
l_F=28;
l_H=18;
n1=50;
n2=50;
n3=50; 
alfaMin=-20*pi/180;
alfaMax=40*pi/180;
betaMin=0*pi/180;
betaMax=80*pi/180;
gammaMin=-70*pi/180;
gammaMax=80*pi/180;
alfa=linspace(alfaMin,alfaMax,n1);
beta=linspace(betaMin,betaMax,n2);
gamma=linspace(gammaMin,gammaMax,n3);

mu=[40 -20];
sigma=[1250 0; 0 500];

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

plot(x_H, y_H,'.')
hold on
plot(0,0,'k.','MarkerSize',25)
grid on
hold on
title('Original mobility','fontsize',15)
xlabel('Horizontal distance from the shoulder','fontsize',15)
ylabel('Vertical distance from the shoulder','fontsize',15)
set(gca,'FontSize',15)
set(gcf,'Position',[299 116 638 561])


n=10000;
% figure()
% plot(0, 0,'.')
% grid on
% hold on
% title('Boundary for the finger tip','fontsize',11)
% xlabel('Horizontal distance from the shoulder','fontsize',11)
% ylabel('Vertical distance from the shoulder','fontsize',11)
%tau_out outer bound
gamma_l=0;
if betaMin>0
    f=@(g)(-Distance((alfaMin+alfaMax)/2, betaMin, g, l_A, l_F, l_H))
    gamma_l=fmincon(f, 0, [], [], [], [], gammaMin, gammaMax);
end
gammaTest=linspace(gammaMin,gamma_l,n);
axis square
[X Y]=ArmPosition(alfaMin, betaMin, gammaTest, l_A, l_F, l_H);
hold on
X_b=X;
Y_b=Y;
plot(X, Y, '--r','LineWidth',2)
if betaMin<0
    betaTest=linspace(betaMin, 0,n);
    [X Y]=ArmPosition(alfaMin, betaTest, gamma_l, l_A, l_F, l_H);
    plot(X, Y, '--k','LineWidth',2)
    X_b=[X_b X];
    Y_b=[Y_b Y];
end
alfaTest=linspace(alfaMin, alfaMax, 1000*n);
[X Y]=ArmPosition(alfaTest, max([0 betaMin]), gamma_l, l_A, l_F, l_H);
plot(X, Y, '--g','LineWidth',2)
X_b=[X_b X];
Y_b=[Y_b Y];
betaTest=linspace(max([0 betaMin]), betaMax,10*n);
[X Y]=ArmPosition(alfaMax, betaTest, gamma_l, l_A, l_F, l_H);
plot(X, Y, '--y','LineWidth',2)
X_b=[X_b X];
Y_b=[Y_b Y];
gammaTest=linspace(gamma_l,gammaMax,n);
[X Y]=ArmPosition(alfaMax, betaMax, gammaTest, l_A, l_F, l_H);
plot(X, Y, '--m','LineWidth',2)
X_b=[X_b X];
Y_b=[Y_b Y];

%tau_in inner bound
alfaTest=linspace(alfaMax, alfaMin,n);
[X Y]=ArmPosition(alfaTest, betaMax, gammaMax, l_A, l_F, l_H);
plot(X, Y, 'c','LineWidth',2)
X_b=[X_b X];
Y_b=[Y_b Y];
[x_right I]=max(X);
y_right=Y(I);

if abs(gammaMax)<abs(gammaMin)
    f=@(ab)(DistBet(alfaMin, ab(1), ab(2), betaMax,  gammaMax, gammaMin, l_A, l_F, l_H))
    lb=[alfaMin betaMin];
    ub=[alfaMax betaMax];
    start=[alfaMin betaMax]
    ab_unknown=fmincon(f,start,[], [], [], [],lb, ub)

    betaTest=linspace(betaMax, ab_unknown(2),10*n);
    [X Y]=ArmPosition(alfaMin, betaTest, gammaMax, l_A, l_F, l_H);
    plot(X, Y, 'r','LineWidth',2)
    [M I]=max(X);
    if M>x_right
        x_right=M;
        y_right=Y(I);
    end
    X_b=[X_b X];
    Y_b=[Y_b Y];
    grid on

    alfaTest=linspace(ab_unknown(1), alfaMin,n);
    [X Y]=ArmPosition(alfaTest, betaMax, gammaMin, l_A, l_F, l_H);
    plot(X, Y, 'r','LineWidth',2)
    [M I]=max(X);
    if M>x_right
        x_right=M;
        y_right=Y(I);
    end
    X_b=[X_b X];
    Y_b=[Y_b Y];
    if betaMin>=0

        betaTest=linspace(betaMax, betaMin ,10*n);
        [X Y]=ArmPosition(alfaMin, betaTest, gammaMin, l_A, l_F, l_H);
        plot(X, Y, 'g','LineWidth',2)
        [M I]=max(X);
        if M>x_right
            x_right=M;
            y_right=Y(I);
        end
        X_b=[X_b X];
        Y_b=[Y_b Y];
    else
        f2=@(ab)(DistBet(alfaMin, ab(1),ab(2), betaMin, gammaMin, gammaMin, l_A, l_F, l_H))
        lb=[alfaMin+0.5 betaMin+0.5];
        ub=[alfaMax betaMax];
        start=[(alfaMax+alfaMin)/2 (betaMax+betaMin)/2]
        ab_unknown=fmincon(f2, start, [],[],[],[],lb,ub);
        betaTest=linspace(betaMax, ab_unknown(2) ,10*n);
        [X Y]=ArmPosition(alfaMin, betaTest, gammaMin, l_A, l_F, l_H);
        plot(X, Y, 'g','LineWidth',2)
        [M I]=max(X);
        if M>x_right
            x_right=M;
            y_right=Y(I);
        end
        X_b=[X_b X];
        Y_b=[Y_b Y];
        alfaTest=linspace(ab_unknown(1), alfaMin ,10*n);
        [X Y]=ArmPosition(alfaTest, betaMin, gammaMin, l_A, l_F, l_H);
        plot(X, Y, 'c','LineWidth',2)
        [M I]=max(X);
        if M>x_right
            x_right=M;
            y_right=Y(I);
        end
        X_b=[X_b X];
        Y_b=[Y_b Y];
    end
    
else
    betaTest=linspace(betaMax, betaMin,10*n);
    [X Y]=ArmPosition(alfaMin, betaTest, gammaMax, l_A, l_F, l_H);
    plot(X, Y, 'r','LineWidth',2)
    [M I]=max(X);
    if M>x_right
        x_right=M;
        y_right=Y(I);
    end
    X_b=[X_b X];
    Y_b=[Y_b Y];
    
    if betaMin>0
        f1=@(abgg)(Distance( abgg(1) ,abgg(2), abgg(3), l_A, l_F, l_H )+Distance( alfaMin ,betaMin, abgg(4), l_A, l_F, l_H ));
        lb=[alfaMin betaMin gammaMin gammaMin];
        ub=[alfaMax betaMax gammaMax gammaMax];
        C=@(abgg)deal(Distance(alfaMin, betaMin , gammaMax, l_A, l_F, l_H)-Distance(alfaMin, betaMin, abgg(4), l_A, l_F, l_H), DistBet(abgg(1),alfaMin, abgg(2), betaMin,abgg(3) , abgg(4), l_A, l_F, l_H));
        options=optimset('MaxFunEvals',10000, 'MaxIter', 10000);
        gStart=gammaMin+betaMin*3;
        while gStart>0
            gStart=gStart-betaMin;
        end
        bStart=betaMin;
        aStart=(alfaMax+alfaMin)/2;
        if betaMin>20*pi/180;
            aStart = aStart- betaMin;
        end
        start=[aStart bStart gStart gammaMax];
        abgg_unknown=fmincon(f1, start,[], [], [], [], lb, ub, C, options);



        gammaTest=linspace(gammaMax, abgg_unknown(4), n);
        [X Y]=ArmPosition(alfaMin, betaMin, gammaTest, l_A, l_F, l_H);
        plot(X, Y, 'y','LineWidth',2)
        X_b=[X_b X];
        Y_b=[Y_b Y];

        gammaTest=linspace(abgg_unknown(3), gammaMin, n);
        [X Y]=ArmPosition(abgg_unknown(1), abgg_unknown(2), gammaTest, l_A, l_F, l_H);
        plot(X, Y, 'r','LineWidth',2)
        X_b=[X_b X];
        Y_b=[Y_b Y];    

        betaTest=linspace(abgg_unknown(2), betaMin, n);
        [X Y]=ArmPosition(abgg_unknown(1), betaTest, gammaMin, l_A, l_F, l_H);
        plot(X, Y, 'g','LineWidth',2)
        X_b=[X_b X];
        Y_b=[Y_b Y];

        alfaTest=linspace(abgg_unknown(1), alfaMin, n);
        [X Y]=ArmPosition(alfaTest, betaMin, gammaMin, l_A, l_F, l_H);
        plot(X, Y, 'c','LineWidth',2)
        X_b=[X_b X];
        Y_b=[Y_b Y];
    
        else
    
        f=@(abg)(Distance( abg(1) , abg(2), gammaMin, l_A, l_F, l_H )+Distance( alfaMin , betaMin, abg(3), l_A, l_F, l_H ));
        
        lb=[alfaMin betaMin gammaMin];
        ub=[alfaMax betaMax gammaMax];
        C=@(abg)deal(Distance(alfaMin, betaMin, gammaMax,l_A, l_F, l_H)-Distance(alfaMin, betaMin, abg(3),l_A, l_F, l_H), DistBet(alfaMin, abg(1), betaMin, abg(2), abg(3), gammaMin, l_A, l_F, l_H));
        abg_unknown=fmincon(f, [alfaMax betaMin gammaMax],[], [], [], [], lb, ub, C);
        
        
        if abg_unknown(3)<gammaMax
            gammaTest=linspace(gammaMax, abg_unknown(3), n);
            [X Y]=ArmPosition(alfaMin, betaMin, gammaTest, l_A, l_F, l_H);
            plot(X, Y, 'y','LineWidth',2)
            X_b=[X_b X];
            Y_b=[Y_b Y];
        end
        if abg_unknown(2)>betaMin
            betaTest=linspace(abg_unknown(2), betaMin, n);
            [X Y]=ArmPosition(abg_unknown(1), betaTest, gammaMin, l_A, l_F, l_H);
            plot(X, Y, 'g','LineWidth',2)
            X_b=[X_b X];
            Y_b=[Y_b Y];
        end

        alfaTest=linspace(abg_unknown(1), alfaMin, n);
        [X Y]=ArmPosition(alfaTest, betaMin, gammaMin, l_A, l_F, l_H);
        plot(X,Y, 'm','LineWidth',2)
        X_b=[X_b X];
        Y_b=[Y_b Y];

    end
end
%legend('Shoulder','\tau_{H_1}','\tau_{H_2}', '\tau_{H_3}', '\tau_{H_4}', '\tau_{H_5}','\tau_{I_1}', '\tau_{I_2}' ,'\tau_{I_3}','fontsize',11 )

axis square

axis([-40 70 -80 20])
ax=axis;


% return


figure()
plot(X_b, Y_b, 'LineWidth',2)
grid on
hold on
axis square

% return

%Area MC
[x_tail y_tail]=ArmPosition(alfaMin, betaMin, gammaMin, l_A, l_F, l_H);
%index=find(abs(Y_b-y_tail)<0.01);
%index=index(length(index)-1); %Check in every case!
%x_right=X_b(index);
%x_right=x_right;
Xmax=max(X_b);
Xmin=min(X_b);
Xdif=Xmax-Xmin;
Ymax=max(Y_b);
Ymin=min(Y_b);
Ydif=Ymax-Ymin;
dif=[Xdif Ydif];
start=[Xmin Ymin];
tol=max(diff(X_b));

N=5000;
sum=0;
Importance=0;
for i=1:N

    P=start + rand(1,2).*dif;
    %plot(P(1), P(2), 'o')

    Xindex=find(abs(X_b-P(1))<tol);
    Ypoints=Y_b(Xindex);
    if (P(2)<y_right & P(1)<x_right)
        Ypoints=Ypoints(find(Ypoints<y_right));
    elseif P(1)<x_right
        Ypoints=Ypoints(find(Ypoints >= y_right));
    end
    if (P(2)<=max(Ypoints) & P(2)>=min(Ypoints))
        sum=sum+1;
        Importance=Importance+mvnpdf(P,mu,sigma);

        plot(P(1), P(2), 'gx')
    else
        plot(P(1), P(2), 'rx')
    end
end
Area = sum/N*dif(1)*dif(2)
Importance

title('Monte-Carlo simulation','fontsize',15)
xlabel('Horizontal distance from the shoulder','fontsize',15)
ylabel('Vertical distance from the shoulder','fontsize',15)

vv=20;
[p1, p2]=meshgrid(linspace(ax(1),ax(2),50),linspace(ax(3),ax(4),50));
y = mvnpdf([p1(:),p2(:)],mu,sigma);
y=reshape(y,size(p1,1),size(p1,2));
y2=y.*(repmat(p1(1,:),size(p1,1),1)>vv);
contour(p1,p2,y2,'LineWidth',1.5)
plot(0,0,'k.','MarkerSize',25)
set(gca,'FontSize',15)
set(gcf,'Position',[299 116 638 561])

% return
figure()
plot(X_b, Y_b,'LineWidth', 2)
grid off
hold on
axis square
y_l=Ymin:1:Ymax;
n_y=length(y_l);
x_l=Xmin:1:Xmax;
x_l2=Xmin:1:x_right;
n_x=length(x_l);
n_x2=length(x_l2);
plot(x_right*ones(n_y,1),y_l,'r',x_l2, y_right*ones(n_x2, 1),'r', x_right, y_right, 'ko','LineWidth', 2)
plot(ones(n_y,1)*Xmin, y_l,'k',ones(n_y,1)*Xmax, y_l,'k',x_l,ones(n_x,1)*Ymin, 'k',x_l,ones(n_x,1)*Ymax,'k','LineWidth', 2)

P=[40 -40];


plot(ones(n_y,1)*(P(1)-2), y_l, 'm:', ones(n_y,1)*(P(1)+2), y_l, 'm:','LineWidth', 1.5)
plot(P(1),P(2), 'gx', 'LineWidth', 4)

P=[5 -30];
y_l2=Ymin:1:y_right;
n_y2=length(y_l2);

plot(ones(n_y2,1)*(P(1)-2), y_l2, 'm:', ones(n_y2,1)*(P(1)+2), y_l2, 'm:','LineWidth', 1.5)
plot(P(1),P(2), 'rx', 'LineWidth', 4)
title('Illustrative picture','fontsize',12)
xlabel('Horizontal distance from the shoulder','fontsize',12)
ylabel('Vertical distance from the shoulder','fontsize',11)

toc



%% Comparison
x1=load('xb1');
y1=load('yb1');
x2=load('xb2');
y2=load('yb2');


mu=[40 -20];
sigma=[1250 0; 0 500];
axis([-40 70 -80 20])
ax=axis;

vv=20;
[p1, p2]=meshgrid(linspace(ax(1),ax(2),50),linspace(ax(3),ax(4),50));
y = mvnpdf([p1(:),p2(:)],mu,sigma);
y=reshape(y,size(p1,1),size(p1,2));
yy=y.*(repmat(p1(1,:),size(p1,1),1)>vv);

figure
contourf(p1,p2,yy)
hold on
plot(x1.X_b,y1.Y_b,'k','LineWidth',2)
plot(x2.X_b,y2.Y_b,'k--','LineWidth',2)
axis([-40 70 -80 20])
legend('Weights','Treatment 1','Treatment 2')
% plot(0,0,'k.','MarkerSize',25)
title('Comparison of the two treatments','fontsize',15)
xlabel('Horizontal distance from the shoulder','fontsize',15)
ylabel('Vertical distance from the shoulder','fontsize',15)
set(gca,'FontSize',15)
set(gcf,'Position',[299 116 638 561])

%% weigths
ax=[-80 80 -80 60];
vv=20;
n1=100;
n2=100;
mu=[40 -20];
sigma=[1250 0; 0 500];
[p1 p2]=meshgrid(linspace(ax(1),ax(2),n1),linspace(ax(3),ax(4),n2));
y = mvnpdf([p1(:),p2(:)],mu,sigma);
y=reshape(y,size(p1,1),size(p1,2));
y2=y.*(repmat(p1(1,:),size(p1,1),1)>vv);
figure
grid off
% pcolor(p1,p2,y2)
% surf(p1,p2,y2)
contourf(p1,p2,y2,40)
hold on
plot(Xhand,Yhand,'k','LineWidth',2)
plot([vv vv],[ax(3:4)],'w','LineWidth',2)
axis xy
axis square
set(gca,'Fontsize',16)