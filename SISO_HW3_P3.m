clear all
clc

T1 = 10;
T2 = 2;
T_num = [1];
T_den = [T2 1 0];
sys = tf(T_num,T_den,'InputDelay',T1);

P=nyquistoptions;
P.ShowFullContour ='off';
nyquistplot(sys,P)

