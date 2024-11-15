clear all
clc

eps =15.5;
ht=35;
hr=1.7;
q= 0.33*10^-8;
lambda1 =0.33; %900Mhz
lambda2 =0.16; %1800Mhz
lambda3 =0.09; %3500Mhz

axis=[];
Rv=[]; Rh=[];
kd=[];
Ev=[]; Eh=[];
E0=[];
beta= [];
Rd=[];Ri=[];
Ea=[];Eb=[];
for i=1000:4000
 d=10^(i/1000);
 axis =[axis d];
beta= [beta,asin((ht+hr)/d)]; %Gazing angle
Rd=[Rd,sqrt(d^2+(ht-hr)^2)]; %line of sight distance :Rd value
Ri =[Ri,sqrt(d^2+(ht+hr)^2)];%reflected path distance: Ri value
dt = Ri - Rd;

% Reflection Coefficients
Rv= (-eps*sin(beta)+sqrt(eps - cos(beta).^2))./(eps*sin(beta)+sqrt(eps-cos(beta).^2)); 
Rh= ( sin(beta)-sqrt(eps - cos(beta).^2))./(sin(beta)+sqrt(eps-cos(beta).^2));

%900MHz Electric field strength
k1= (2*pi/lambda1);
E01 = (exp(-j*k1*Rd)./Rd);
Ev1 = 20*log10(abs(E01 .* (1 + Rv.* exp(-j*k1*dt)))); % Vertically
Eh1 = 20*log10(abs(E01 .* (1 + Rh.* exp(-j*k1*dt)))); % Horizontally

%1800MHz Electric field strength
k2= (2*pi/lambda2);
E02 = (exp(-j*k2*Rd)./Rd);
Ev2 = 20*log10(abs(E02 .* (1 + Rv.* exp(-j*k2*dt))));
Eh2 = 20*log10(abs(E02 .* (1 + Rh.* exp(-j*k2*dt))));

%3500MHz Electric field strength
k3= (2*pi/lambda3);
E03 = (exp(-j*k3*Rd)./Rd);
Ev3 = 20*log10(abs(E03 .* (1 + Rv.* exp(-j*k3*dt))));
Eh3 = 20*log10(abs(E03 .* (1 + Rh.* exp(-j*k3*dt))));

%Before the breakpoint, the average power of the field decays 𝑑^-2 . 
%For ,d < db
db=(4*ht*hr/lambda1); % For 900MHz
% db=(4*ht*hr/lambda2); % For 1800MHz
% db=(4*ht*hr/lambda3); % For 3500MHz
if d < db;
Eb = [Eb,-5*log10(2*d)];
else
%After the breakpoint , For ,d > db
Ea = [Ea,-5*log10(d)+ 20*log10((4*pi*ht*ht)/(lambda1*d))]; % For 900MHz
% Ea = [Ea,-5*log10(d)+ 20*log10((4*pi*ht*ht)/(lambda2*d))]; % For 1800MHz
% Ea = [Ea,-5*log10(d)+ 20*log10((4*pi*ht*ht)/(lambda3*d))]; % For 3500MHz
end

end

semilogx(axis,Ev1,'r',axis,Eh1,'b');
legend('Vertically polarized electric field','Horizontally polarized electric fields');
title('Electric Field 900MHz');
xlabel('distance in m');
ylabel('electric field strength');
figure
semilogx(axis,Ev2,'r',axis,Eh2,'b');
legend('Vertically polarized electric field','Horizontally polarized electric fields');
title('Electric Field 1800MHz');
xlabel('distance in m');
ylabel('Electric field strength');
figure
semilogx(axis,Ev3,'r',axis,Eh3,'b');
legend('Vertically polarized electric field','Horizontally polarized electric fields');
title('Electric Field 3500MHz');
xlabel('distance in m');
ylabel('electric field strength');
xlabel('distance in m');
ylabel('Electric field strength');
figure
plot(axis,[Eb,Ea]);
xlabel('distance in m');
ylabel('Electric field strength');
title('Electric field strength vs Break point Distance ');