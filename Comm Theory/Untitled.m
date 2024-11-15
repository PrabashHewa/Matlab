B=40*10^6;
fc=500*10^6;
df=10*10^6;
phy=pi/2;
ome=2*pi*(fc+df);
t=0:0.1:1000;
x=sinc(B.*t);

plot(x,t)