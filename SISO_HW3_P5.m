clear all
clc

% Solve for T(s)
syms T1 T wn s C m
Teq = (wn^2*(T1*s+1))/((s^2+2*C*wn*s+wn^2)*(T*s+1));
T_new = (wn^2*(T*s+2*(C/wn)*s+1))/((s^2+2*C*wn*s+wn^2)*(T*s+1));
dT = diff(Teq,s)
dt_zero = subs(dT,s,0)

% Input T, C, wn
a = 0.5;               % Tau
b = 2;              % damping ratio >= 0.5
c = 1.5;            % undamped frequency >= 1.5
T_eq = subs(T_new,{T,C,wn},[a,b,c])

% Convert T(s) to tf
[nT,dT] = numden(T_eq);  
T_n = expand(nT);
T_d = expand(dT);
T_num = double(fliplr(coeffs(T_n)));
T_den = double(fliplr(coeffs(T_d)));
T_tf = tf(T_num,T_den)

% Youla
Gp = (s+6)/((s+4)*(s^2+2*s+(5/4)))
Y = T_eq/Gp;
Y_s = Teq/Gp
[ny,dy] = numden(Y);  
Y_n = expand(ny);
Y_d = expand(dy);
Y_num = double(fliplr(coeffs(Y_n)));
Y_den = double(fliplr(coeffs(Y_d)));
Y_tf = tf(Y_num, Y_den)

% Gc
Gc_s = Y_s/(1+Teq)
[nc,dc] = numden(Gc_s);
Gc_sn = expand(nc);
Gc_sd = expand(dc);
Gc_snum = double(fliplr(coeffs(Gc_sn)));
Gc_sden = double(fliplr(coeffs(Gc_sd)));
Gc_stf = tf(Gc_snum, Gc_sden);

Gc = Y/(1+T_eq);
[n,d] = numden(Gc);
Gc_n = expand(n);
Gc_d = expand(d);
Gc_num = double(fliplr(coeffs(Gc_n)));
Gc_den = double(fliplr(coeffs(Gc_d)));
Gc_tf = tf(Gc_num, Gc_den)

% Step Input plot
t=0:0.1:10;
step(T_tf,t)
S = stepinfo(T_tf)
h = stepplot(T_tf);
% p = getoptions(h)


