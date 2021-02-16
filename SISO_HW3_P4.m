clear all
clc

% Pade
syms s
Gp = (exp(-0.2*s))/(1+0.2*s);
Gp_num = 1;
Gp_den = [0.2 1];
Gp_tf = tf(Gp_num, Gp_den, 'InputDelay',0.2);

Gp_1 = ((1-0.1*s)/(1+0.1*s))*(1/(1+0.2*s));
[n1,d1] = numden(Gp_1);
Gp1_n = expand(n1);
Gp1_d = expand(d1);
Gp1_num = double(fliplr(coeffs(Gp1_n)));
Gp1_den = double(fliplr(coeffs(Gp1_d)));
Gp1_tf = tf(Gp1_num, Gp1_den);

Gp_2 = ((1-0.1*s+0.0033*s^2)/(1+0.1*s+0.0033*s^2))*(1/(1+0.2*s));
[n2,d2] = numden(Gp_2);
Gp2_n = expand(n2);
Gp2_d = expand(d2);
Gp2_num = double(fliplr(coeffs(Gp2_n)));
Gp2_den = double(fliplr(coeffs(Gp2_d)));
Gp2_tf = tf(Gp2_num, Gp2_den);

t=0:0.0001:1.5;
step(Gp_tf,t)
hold on
step(Gp1_tf,t)
hold on
step(Gp2_tf,t)
legend('Pure Delay','1st Pade Approx.','2nd Pade Approx.')
title('Pade Approximations')
hold off