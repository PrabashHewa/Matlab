%Sampling  Example
Fs= 1500;
Ts=1/Fs;
T=0:Ts:0.5;
x=sin(2*pi*100*T);
figure
plot(T,x)

%Example DFT

F_x=fft(x);
Nx=length(x);
F0=1/(Ts*Nx);

freq1=0:F0:(Nx-1)*F0;
figure;
plot(freq1,abs(F_x)/Nx);

freq2=-Nx/2*F0:F0:(Nx/2-1)*F0;
figure;
plot(freq2,fftshift(abs(F_x)/Nx));

