clear all
clc
syms s

% Gp and thetap
Gp = (0.01/(s*(s+0.01)*(s+10)));
[np,dp] = numden(Gp);
Gp_n = expand(np);
Gp_d = expand(dp);
Gp_num = double(fliplr(coeffs(Gp_n)));
Gp_den = double(fliplr(coeffs(Gp_d)));
Gp_tf = tf(Gp_num, Gp_den);

% Youla
syms Tau s
Y_s = s/(0.01*(Tau*s+10));
a = 1;                         % Substitute Tau
Y = subs(Y_s,Tau,a);      
[ny,dy] = numden(Y);  
Y_n = expand(ny);
Y_d = expand(dy);
Y_num = double(fliplr(coeffs(Y_n)));
Y_den = double(fliplr(coeffs(Y_d)));
Y_tf = tf(Y_num, Y_den)

% Derive T(s) to solve to T1 
T = Gp*Y;
[nt,dt] = numden(T);
T_n = expand(nt);
T_d = expand(dt);
T_num = double(fliplr(coeffs(T_n)));
T_den = double(fliplr(coeffs(T_d)));
T_tf = tf(T_num, T_den);

% Gc
Gc = Y/(1 + T);
[n,d] = numden(Gc);
Gc_n = expand(n);
Gc_d = expand(d);
Gc_num = double(fliplr(coeffs(Gc_n)));
Gc_den = double(fliplr(coeffs(Gc_d)));
Gc_tf = tf(Gc_num, Gc_den)

% L(s) = Gp*Gc
L_s = Gc*Gp;
[nl,dl] = numden(L_s);
L_n = expand(nl);
L_d = expand(dl);
L_num = double(fliplr(coeffs(L_n)));
L_den = double(fliplr(coeffs(L_d)));
L_tf = tf(L_num, L_den)

% S(s) = 1/(1+L)
S_s = 1/(1+L_s);
[ns,ds] = numden(S_s);
S_n = expand(ns);
S_d = expand(ds);
S_num = double(fliplr(coeffs(S_n)));
S_den = double(fliplr(coeffs(S_d)));
S_tf = tf(S_num, S_den);

% Bode plots
figure(1)
bode(Y_tf);
hold on
bode(L_tf);
hold on
bode(Gc_tf);
hold on
bode(S_tf);
hold on
bode(T_tf);
hold off

% Step Response
figure(2)
stepplot(T_tf);
S = stepinfo(T_tf)







