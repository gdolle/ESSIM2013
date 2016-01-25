function [ AreaMC] = ArmArea( alfaMin, alfaMax, betaMin, betaMax, gammaMin, gammaMax, l_A, l_F, l_H, N, plotOn )
%Calculate the area that can be reached by the finger tip given the
%characteristics of the arm. N is the number of Monte-Corlo-simulations.
%plotOn==1  one get a picture
%   Detailed explanation goes here

%First the boundary is calculated

%tau_out outer bound

n=1000;

gamma_l=0;
if betaMin>0
    f=@(g)(-Distance((alfaMin+alfaMax)/2, betaMin, g, l_A, l_F, l_H));
    gamma_l=fmincon(f, 0, [], [], [], [], gammaMin, gammaMax);
end
gammaTest=linspace(gammaMin,gamma_l,n);
[X Y]=ArmPosition(alfaMin, betaMin, gammaTest, l_A, l_F, l_H);
hold on
X_b=X;
Y_b=Y;

if betaMin<0
    betaTest=linspace(betaMin, 0,n);
    [X Y]=ArmPosition(alfaMin, betaTest, gamma_l, l_A, l_F, l_H);
    X_b=[X_b X];
    Y_b=[Y_b Y];
end
alfaTest=linspace(alfaMin, alfaMax, 1000*n);
[X Y]=ArmPosition(alfaTest, max([0 betaMin]), gamma_l, l_A, l_F, l_H);
X_b=[X_b X];
Y_b=[Y_b Y];
betaTest=linspace(max([0 betaMin]), betaMax,10*n);
[X Y]=ArmPosition(alfaMax, betaTest, gamma_l, l_A, l_F, l_H);
X_b=[X_b X];
Y_b=[Y_b Y];
gammaTest=linspace(gamma_l,gammaMax,n);
[X Y]=ArmPosition(alfaMax, betaMax, gammaTest, l_A, l_F, l_H);
X_b=[X_b X];
Y_b=[Y_b Y];


%tau_in inner bound
alfaTest=linspace(alfaMax, alfaMin,n);
[X Y]=ArmPosition(alfaTest, betaMax, gammaMax, l_A, l_F, l_H);
X_b=[X_b X];
Y_b=[Y_b Y];
[x_right I]=max(X);
y_right=Y(I);

if abs(gammaMax)<abs(gammaMin)
    f=@(ab)(DistBet(alfaMin, ab(1), ab(2), betaMax,  gammaMax, gammaMin, l_A, l_F, l_H));
    lb=[alfaMin betaMin];
    ub=[alfaMax betaMax];
    start=[alfaMin betaMax];
    ab_unknown=fmincon(f,start,[], [], [], [],lb, ub);

    betaTest=linspace(betaMax, ab_unknown(2),10*n);
    [X Y]=ArmPosition(alfaMin, betaTest, gammaMax, l_A, l_F, l_H);
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
        [M I]=max(X);
        if M>x_right
            x_right=M;
            y_right=Y(I);
        end
        X_b=[X_b X];
        Y_b=[Y_b Y];
    else
        f2=@(ab)(DistBet(alfaMin, ab(1),ab(2), betaMin, gammaMin, gammaMin, l_A, l_F, l_H));
        lb=[alfaMin+0.5 betaMin+0.5];
        ub=[alfaMax betaMax];
        start=[(alfaMax+alfaMin)/2 (betaMax+betaMin)/2];
        ab_unknown=fmincon(f2, start, [],[],[],[],lb,ub);
        betaTest=linspace(betaMax, ab_unknown(2) ,10*n);
        [X Y]=ArmPosition(alfaMin, betaTest, gammaMin, l_A, l_F, l_H);
        [M I]=max(X);
        if M>x_right
            x_right=M;
            y_right=Y(I);
        end
        X_b=[X_b X];
        Y_b=[Y_b Y];
        alfaTest=linspace(ab_unknown(1), alfaMin ,10*n);
        [X Y]=ArmPosition(alfaTest, betaMin, gammaMin, l_A, l_F, l_H);
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
        X_b=[X_b X];
        Y_b=[Y_b Y];

        gammaTest=linspace(abgg_unknown(3), gammaMin, n);
        [X Y]=ArmPosition(abgg_unknown(1), abgg_unknown(2), gammaTest, l_A, l_F, l_H);
        X_b=[X_b X];
        Y_b=[Y_b Y];    

        betaTest=linspace(abgg_unknown(2), betaMin, n);
        [X Y]=ArmPosition(abgg_unknown(1), betaTest, gammaMin, l_A, l_F, l_H);
        X_b=[X_b X];
        Y_b=[Y_b Y];

        alfaTest=linspace(abgg_unknown(1), alfaMin, n);
        [X Y]=ArmPosition(alfaTest, betaMin, gammaMin, l_A, l_F, l_H);
        X_b=[X_b X];
        Y_b=[Y_b Y];
    
        else
    
        f=@(abg)(Distance( abg(1) , abg(2), gammaMin, l_A, l_F, l_H )+Distance( alfaMin , betaMin, abg(3), l_A, l_F, l_H ));
        lb=[alfaMin betaMin gammaMin];
        ub=[alfaMax betaMax gammaMax];
        C=@(abg)deal(Distance(alfaMin, betaMin, gammaMax,l_A, l_F, l_H)-Distance(alfaMin, betaMin, abg(3),l_A, l_F, l_H), DistBet(alfaMin, abg(1), betaMin, abg(2), abg(3), gammaMin, l_A, l_F, l_H));
        abg_unknown=fmincon(f, [alfaMax/2 betaMin gammaMax],[], [], [], [], lb, ub, C);
        
        if abg_unknown(3)<gammaMax
            gammaTest=linspace(gammaMax, abg_unknown(3), n);
            [X Y]=ArmPosition(alfaMin, betaMin, gammaTest, l_A, l_F, l_H);
            
            X_b=[X_b X];
            Y_b=[Y_b Y];
        end
        if abg_unknown(2)>betaMin
            betaTest=linspace(abg_unknown(2), betaMin, n);
            [X Y]=ArmPosition(abg_unknown(1), betaTest, gammaMin, l_A, l_F, l_H);
            
            X_b=[X_b X];
            Y_b=[Y_b Y];
        end

        alfaTest=linspace(abg_unknown(1), alfaMin, n);
        [X Y]=ArmPosition(alfaTest, betaMin, gammaMin, l_A, l_F, l_H);
        
        X_b=[X_b X];
        Y_b=[Y_b Y];

    end
end


if plotOn==1
    figure()
    plot(X_b, Y_b, 'LineWidth',2)
    grid on
    hold on
    axis square
end



%Area MC
Xmax=max(X_b);
Xmin=min(X_b);
Xdif=Xmax-Xmin;
Ymax=max(Y_b);
Ymin=min(Y_b);
Ydif=Ymax-Ymin;
dif=[Xdif Ydif];
start=[Xmin Ymin];
tol=max(diff(X_b));

sum=0;
for i=1:N

    P=start + rand(1,2).*dif;
    

    Xindex=find(abs(X_b-P(1))<tol);
    Ypoints=Y_b(Xindex);
    if (P(2)<y_right & P(1)<x_right)
        Ypoints=Ypoints(find(Ypoints<y_right));
    elseif P(1)<x_right
        Ypoints=Ypoints(find(Ypoints >= y_right));
    end
    if (P(2)<=max(Ypoints) & P(2)>=min(Ypoints))
        sum=sum+1;
%         if plotOn==1
%             plot(P(1), P(2), 'gx')
%         end
%    else
%         if plotOn==1
%             plot(P(1), P(2), 'rx')
%         end
    end
end
AreaMC = sum/N*dif(1)*dif(2);

%AreaAn=tip_area_analytic(alfa_unknown,alfaMin, alfaMax, betaMin, betaMax, gammaMin, gammaMax, l_A, l_F, l_H);
AreaAn=0;
end

