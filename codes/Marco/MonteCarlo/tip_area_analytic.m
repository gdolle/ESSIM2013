function [A] = tip_area_analytic(alfa_unknown,alfaMin, alfaMax, betaMin, betaMax, gammaMin, gammaMax, l_A, l_F, l_H)


phi_x = @(alfa,beta,gamma) l_A*sin(alfa)+l_F*sin(alfa+beta)+l_H*sin(alfa+beta+gamma);

n_gamma = @(alfa,beta,gamma) -l_H * sin(alfa+beta+gamma);
n_beta  = @(alfa,beta,gamma) -l_F * sin(alfa+beta) - l_H*sin(alfa+beta+gamma);
n_alfa  = @(alfa,beta,gamma) -l_A*sin(alfa)-l_F*sin(alfa+beta)-l_H*sin(alfa+beta+gamma);

I1 = quad(@(gamma) (phi_x(alfaMin,betaMin,gamma) .* n_gamma(alfaMin,betaMin,gamma)),gammaMin,0);

I2 = quad(@(beta) (phi_x(alfaMin,beta,0) .* n_beta(alfaMin,betaMin,0)),betaMin,0);

I3 = quad(@(alfa) (phi_x(alfa,0,0) .* n_alfa(alfa,0,0)),alfaMin,alfaMax);

I4 = quad(@(beta) (phi_x(alfaMax,beta,0) .* n_beta(alfaMax,beta,0)),0,betaMax);

I5 = quad(@(gamma) (phi_x(alfaMax,betaMax,gamma) .* n_gamma(alfaMax,betaMax,gamma)),0,gammaMax);

I6 = quad(@(alfa) (phi_x(alfa,betaMax,gammaMax) .* n_alfa(alfa,betaMax,gammaMax)),alfaMax,alfaMin);

I7 = quad(@(beta) (phi_x(alfaMin,beta,gammaMax) .* n_beta(alfaMin,beta,gammaMax)),betaMax,betaMin);

I8 = quad(@(alfa) (phi_x(alfa,betaMin,gammaMin) .* n_alfa(alfa,betaMin,gammaMin)),alfa_unknown,alfaMin);


A = abs(sum(I1+I2+I3+I4+I5+I6+I7+I8));
%A = [I1,I2,I3,I4,I5,I6,I7,I8];

