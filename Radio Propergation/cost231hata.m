% Okumura/Hata v/s COST231
% Comparision 2
clc;
close all;
clear all;
%common parameters
d = 1:0.001:5;
fc1 = 1000;
fc2 = 1500;
fc3 = 2000;
hm = 3;
hb = 50;
% Okumura/Hata
ahm = 3.2*(log10(11.75*hm)).^2 - 4.97;
Lhata_1 = 69.55 + 26.16*log10(fc1) + (44.9 - 6.55*log10(hb))*log10(d) - 13.82*log10(hb) - ahm;
Lhata_2 = 69.55 + 26.16*log10(fc2) + (44.9 - 6.55*log10(hb))*log10(d) - 13.82*log10(hb) - ahm;
Lhata_3 = 69.55 + 26.16*log10(fc3) + (44.9 - 6.55*log10(hb))*log10(d) - 13.82*log10(hb) - ahm;
                                  
% COST 231
W = 15;
b = 30;
hr = 30;
phi = 90;
dhm = hr - hm;
dhb = hb -hr;
kd = 18 - 15*dhb/dhm;
ka = 54;
kf1 = 4 + 0.7*((fc1/925)-1);
kf2 = 4 + 0.7*((fc2/925)-1);
kf3 = 4 + 0.7*((fc3/925)-1);
    
Lcost_1  = 32.4 + 20*log10(d) + 20*log10(fc1) + -16.9 - 10*log10(W) + 10*log10(fc1) + 20*log(dhm) + 4 - 0.114*(phi-55) + -18*log10(11+dhb) + ka + kd*log10(d) + kf1*log10(fc1) - 9*log10(b);;
Lcost_2  = 32.4 + 20*log10(d) + 20*log10(fc2) + -16.9 - 10*log10(W) + 10*log10(fc2) + 20*log(dhm) + 4 - 0.114*(phi-55) + -18*log10(11+dhb) + ka + kd*log10(d) + kf2*log10(fc2) - 9*log10(b);
Lcost_3  = 32.4 + 20*log10(d) + 20*log10(fc3) + -16.9 - 10*log10(W) + 10*log10(fc3) + 20*log(dhm) + 4 - 0.114*(phi-55) + -18*log10(11+dhb) + ka + kd*log10(d) + kf3*log10(fc3) - 9*log10(b);
              
figure(1); 
plot(d, Lcost_1, 'r', d, Lcost_2, '--r', d, Lcost_3,':r'); 
hold on; 
plot(d, Lhata_1, 'b', d, Lhata_2, '--b', d, Lhata_3,':b');
hold on; 
legend('COST231 f=1000 MHz' ,'COST231 f=1500 MHz' ,'COST231 f=2000 MHz','Hata f=1000 MHz' , 'Hata f=1500 MHz' ,'Hata f=2000 MHz'); 
grid on;
xlabel('d [Km]');
ylabel('L [dB]');
title('Comparision of Okumura/Hata Model and COST231 model ');  