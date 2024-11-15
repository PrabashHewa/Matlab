clear all
clc
f1=900;
f2=1800;
f3=3500;

lambda1 = 0.33;%900MHz Wavelength
lambda2= 0.16;%1800MHz Wavelength
lambda3= 0.09;%3500MHz Wavelength
ht=35; % Base Station height
hr=1.7; % Mobile Station height

axis=[];
p1=[];p2=[];p3=[];
pfsl=[];pfs2=[];pfs3=[];
Lhata_1=[];Lhata_2=[];Lhata_3=[];

for i=1000:4000
 d=10^(i/1000);
 axis =[axis d]; 
 %900MHz
 fspower1  = (lambda1/(4*pi*d))^2 ;
 power1 = fspower1 * 4 *(sin(2*pi*hr*ht/(lambda1*d)))^2;
 ahm1 =(1.1*log10(f1)-0.7)*hr-(1.56*log10(f1)-0.8);
 p1 =[p1, 10*log10(power1)]; %Plane earth loss model 900MHz
 pfsl=[pfsl, 10*log10(fspower1)];%Free space path loss model 900MHz
 Lhata_1 = [Lhata_1,69.55 + 26.16*log10(f1) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahm1 + 20]; %Cost 231-Hata Model Path loss 900MHz
 
 %1800MHz
 fspower2  = (lambda2/(4*pi*d))^2 ;
 power2 = fspower2 * 4 *(sin(2*pi*hr*ht/(lambda2*d)))^2;
 ahm2 =(1.1*log10(f2)-0.7)*hr-(1.56*log10(f2)-0.8);
 p2 =[p2, 10*log10(power2)]; %Plane earth loss model 1800MHz
 pfs2=[pfs2, 10*log10(fspower2)]; %Free space path loss model 1800MHz
 Lhata_2 = [Lhata_2,46.3 + 33.9*log10(f2) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahm2 + 20];%Cost 231-Hata Model Path loss 1800MHz
 
 %3500MHz
 fspower3  = (lambda3/(4*pi*d))^2 ;
 power3 = fspower3 * 4 *(sin(2*pi*hr*ht/(lambda3*d)))^2;
 ahm3 =(1.1*log10(f3)-0.7)*hr-(1.56*log10(f3)-0.8);
 p3 =[p3, 10*log10(power3)]; %Plane earth loss model 3500MHz
 pfs3=[pfs3, 10*log10(fspower3)];%Free space path loss model 3500MHz
 Lhata_3 = [Lhata_3,(46.3 + 33.9*log10(f3) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahm3 + 20)];%Cost 231-Hata Model Path loss 3500MHz
end

semilogx(axis,p1, 'g-',axis,pfsl,'r-')
legend('Plane earth loss model','Free space path loss model');
xlabel('distance in m');
ylabel('pathloss[dB]');
title('Path Loss Comparison 900Mhz');

figure
semilogx(axis,p2, 'g-',axis,pfs2,'r-')
legend('Plane earth loss model','Free space path loss model');
xlabel('distance in m');
ylabel('pathloss[dB]');
title('Path Loss Comparison 1800Mhz');
figure

semilogx(axis,p3, 'g-',axis,pfs2,'r-')
legend('Plane earth loss model','Free space path loss model');
xlabel('distance in m');
ylabel('pathloss[dB]');
title('Path Loss Comparison 3500Mhz');
figure

plot(axis,Lhata_3,'g');
hold on 
plot( axis,Lhata_2,'r');
hold on
plot(axis,Lhata_1,'b');
legend('900Mhz','1800Mhz','3500Mhz');
title('Cost 231-Hata Model Path loss');
xlabel('distance in m');
ylabel('pathloss[dB]');
