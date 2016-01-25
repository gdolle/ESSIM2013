close all
l_A=28;
l_F=28;
n1=100;
n2=100;
alfaMin=-50*pi/180;
alfaMax= 90*pi/180;
betaMin=-10*pi/180;
betaMax=150*pi/180;

alfa=linspace(alfaMin,alfaMax,n1);
beta=linspace(betaMin,betaMax,n2);
gamma=linspace(gammaMin,gammaMax,n3);
x_H=zeros(n1*n2,1);
y_H=zeros(n1*n2,1);
nbr=1;
for i=1:n1
    for j=1:n2
        [x_W(nbr) y_W(nbr)]=WristPosition(alfa(i), beta(j), l_A, l_F);
        nbr=nbr+1;
    end
end

plot(x_W, y_W,'.',0,0,'x')
grid on
axis square
hold on

n=100;
figure()
%tau_out outer bound

betaTest=linspace(betaMin, 0,n);
[X Y]=WristPosition(alfaMin, betaTest, l_A, l_F);
plot(X, Y, 'b')
hold on
X_b=X;
Y_b=Y;
alfaTest=linspace(alfaMin, alfaMax, 1000*n);
[X Y]=WristPosition(alfaTest, 0, l_A, l_F);
plot(X, Y, 'g')
X_b=[X_b X];
Y_b=[Y_b Y];
betaTest=linspace(0, betaMax,10*n);
[X Y]=WristPosition(alfaMax, betaTest,l_A, l_F);
plot(X, Y, 'y')
X_b=[X_b X];
Y_b=[Y_b Y];

%tau_in inner bound
alfaTest=linspace(alfaMax, alfaMin,n);
[X Y]=WristPosition(alfaTest, betaMax, l_A, l_F);
plot(X, Y, 'c')
X_b=[X_b X];
Y_b=[Y_b Y];
[x_right I]=max(X);
y_right=Y(I);
betaTest=linspace(betaMax, betaMin,10*n);
[X Y]=WristPosition(alfaMin, betaTest, l_A, l_F);
plot(X, Y, 'r')
X_b=[X_b X];
Y_b=[Y_b Y];
grid on


figure()
plot(X_b, Y_b)
grid on
hold on

%Area MC
%y_right=y_right;
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

N=10000;
sum=0;
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
        plot(P(1), P(2), 'x')
    end
end
Area = sum/N*dif(1)*dif(2)