eps =15.5;
ht=35;
hr=1.7;
q= 0.33*10^-8;
lambda =0.33; %0.16 and 0.09

axis=[];
Rv=[]; Rh=[];
kd=[];
Ev=[]; Eh=[];
E0=[];
beta= [];
Rd=[];

for i=1000:4000
 d=10^(i/1000);
 axis =[axis d];
beta= [beta,asin((ht+hr)/d)];
Rd=[Rd,sqrt(d^2+(ht+hr)^2)];

Rv= [Rv,10*log10(-eps*sin(beta)+sqrt(eps - cos(beta).^2))/(eps*sin(beta)+sqrt(eps-cos(beta).^2))];
Rh= [Rh,10*log10( sin(beta)-sqrt(eps - cos(beta).^2))/(sin(beta)+sqrt(eps-cos(beta).^2))];
k= (4*pi/lambda)*q;
E0 = [E0,(exp(-i*k*Rd)/Rd)];

kd= [kd,(4*pi/lambda)*(ht*hr/d)];
Ev = 10*log10(E0 .* (1 + Rv.* exp(-i*kd)));
Eh = 10*log10(E0 .* (1 + Rh.* exp(-i*kd)));

end

semilogx(axis,Ev,'g',axis,Eh,'r');
legend('Vertically polarized electric field','Horizontally polarized electric fields');
title('COST 231 Path loss');
