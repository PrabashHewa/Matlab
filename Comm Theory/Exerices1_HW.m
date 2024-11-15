clear; 
close all; 
clc;

%SIGNAL GENERATION
fc=800;
Fs=16000;
Ts=1/Fs;
T=0:Ts:0.1;
x=sin(2*pi*fc*T);

plot(T,x)
title('SIGNAL GENERATION:X(t)') 
xlabel('t[s]')
ylabel('Amplitude')
axis([0 0.1 -1.2 1.2])

F_x=fft(x);
N=length(x);
F0=1/(Ts*N);

frq1=0:F0:(N-1)*F0;
figure;
plot(frq1,abs(F_x)/N);
title('One‐sided amplitude spectrum of x(t)') 
xlabel('f(MHz)')
ylabel('Amplitude')
axis([0 16e3 0 0.5])

frq2=-N/2*F0:F0:(N/2-1)*F0;
figure;
plot(frq2,fftshift(abs(F_x)/N));
title('Two‐sided amplitude spectrum of x(t)')
xlabel('f(MHz)')
ylabel('Amplitude')
axis([-8e3 8e3 0 0.5])
%%
% plot(T,x)
% title('Time domain Plot of x(t)')
% xlabel('t[s]')
% ylabel('Amplitude')
% axis([0 20e-9 -1.2 1.2])
% %[x-axis_left_limit x-axis_right_limit y-axis_down_limit y-axis_up_limit]
%%
% MULTIPLICATION BETWEEN TWO SIGNALS

f=750;
m=sin(2*pi*f*T);
s=x.*m;
plot(T,s);
title('MULTIPLICATION BETWEEN TWO SIGNALS:S(t)')
xlabel('t[s]')
ylabel('Amplitude')
axis([0 0.1 -1.2 1.2])

 F_s=fft(s);
N=length(s);
F0=1/(Ts*N);

frq1=0:F0:(N-1)*F0;
figure;
plot(frq1,abs(F_s)/N);
title('One-sided amplitude Spectrum of s(t)')
xlabel('f(MHz)')
ylabel('Amplitude')
axis([0 16e3 0 0.25])

frq2=-N/2*F0:F0:(N/2-1)*F0;
figure;
plot(frq2,fftshift(abs(F_s)/N));
title('Two‐sided amplitude spectrum of s(t)')
xlabel('f(MHz)')
ylabel('Amplitude')
axis([-8e3 8e3 0 0.25])
%%
%ADDING A NOISE SIGNAL
n=randn(size(x));
y=10*s+n;
plot(T,y);
title('NOISE SIGNAL:Y(t)')
xlabel('t[s]')
ylabel('Amplitude')
axis([0 0.1 -11.2 11.2])

F_y=fft(y);
N=length(y);
F0=1/(Ts*N);

frq1=0:F0:(N-1)*F0;
figure;
plot(frq1,abs(F_y)/N);
title('One-sided amplitude Spectrum of y(t)')
xlabel('f(MHz)')
ylabel('Amplitude')
axis([0 16e3 0 2.5])

frq2=-N/2*F0:F0:(N/2-1)*F0;
figure;
plot(frq2/1e6,fftshift(abs(F_y)/N));
title('Two‐sided amplitude spectrum of y(t)')
xlabel('f(MHz)')
ylabel('Amplitude')
axis([-8e-3 8e-3 0 2.5])
%%
%LOW PASS BUTTERWORTH FILTER
f_cut =200;
order=10;
fr=f_cut/(Fs/2);

figure;
[b,a]=butter(order,fr);
freqz(b,a,N,Fs)
title('Frequency response of the Butterworth filter')

figure;
y_filtered_butter = filter(b,a,y);
plot(T,y_filtered_butter);
title('LOW PASS BUTTERWORTH FILTER OUTPUT')
xlabel('t[s]')
ylabel('Amplitude')
axis([0 0.1 -6 6])

F_yfilter=fft(y_filtered_butter);
N=length(y_filtered_butter);
F0=1/(Ts*N);

frq1=0:F0:(N-1)*F0;
figure;
plot(frq1,abs(F_yfilter)/N);
title('One-sided amplitude spectrum of filtered y(t)')
xlabel('f(MHz)')
ylabel('Amplitude')
axis([0 16e3 0 2.5])

frq2=-N/2*F0:F0:(N/2-1)*F0;
figure;
plot(frq2,fftshift(abs(F_yfilter)/N));
title('Two‐sided amplitude spectrum of filtered y(t)')
xlabel('f(MHz)')
ylabel('Amplitude')
axis([-400 400 0 2.5])

%%
%BAND PASS FIR FILTER

order=60; % filter order
f_filter = [0 0.1 0.1625 0.225 0.2875 1];
a_filter = [0 0 1 1 0 0];
b = firpm(order,f_filter,a_filter);

stem(-order/2:order/2,b)
title('Impulse response of the filter')
xlabel('Normalized Frequency')
ylabel('Amplitude Responce')

F_b = fft(b,N);
figure;
plot(frq1,abs(F_b)/N);
title('Amplitude response of the filter')
xlabel('Frequency')
ylabel('Amplitude Responce')


y_filtered_FIR = filter(b,1,y);
figure;
plot(T,y_filtered_FIR);
title('Filtered signal in time Domain')
xlabel('Time (s)')
ylabel('Amplitude Responce')

figure;
plot(frq1,abs(y_filtered_FIR)/N);
title('Filtered signal in frequency Domain')
xlabel('Frequency')
ylabel('Amplitude Responce')