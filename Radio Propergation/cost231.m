% Cost 231 Model
clc;
close all;
clear all;
d = 1:0.001:5;
fc = input('Enter Carrier Frequency(800-2000MHz)');
W = input('Enter Street Width(m)');
b = input('Enter distance b/w building(m)');
hr = input('Enter height of roof(m)');
hm = input('Enter mobile antenna ht(1-3m)');
dhm = hr - hm;
phi = input('Enter incident angle related to street(0-90degree)');
hb = input('Enter base station ant. ht(4-50m)');
dhb = hb -hr;
if ((phi>0)&&(phi<=35))
    L0 = -10 + 0.354*phi;
elseif((phi>35)&&(phi<=55))
    L0 = 32.5 + 0.075*(phi-35);
elseif((phi>55)&&(phi<=90))
    L0 = 4 - 0.114*(phi-55);
end;
Lf = 32.4 + 20*log10(d) + 20*log10(fc);
Lrts = -16.9 - 10*log10(W) + 10*log10(fc) + 20*log(dhm) + L0;
if(hb>=hr)
    Lbsh = -18*log10(11+dhb);
    kd = 18 - 15*dhb/dhm;
else
    Lbsh = 0;
    kd = 18;
end;
if(hb<=hr)
    ka = 54 - 0.8*hb;
else
    ka = 54;
end;
kf = 4 + 0.7*((fc/925)-1);
Lms = Lbsh + ka + kd*log10(d) + kf*log10(fc) - 9*log10(b);
if((Lrts + Lms)>0)
    L50  = Lf + Lrts + Lms;
else
    L50 = Lf;
end;
figure(1); 
plot(d , L50);
grid on;
xlabel('d [Km]');
ylabel('L [dB]');
title('COST231');