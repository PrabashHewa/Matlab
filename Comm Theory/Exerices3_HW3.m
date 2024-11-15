figure
hold on
for i = 1:2*r:(length(xn)-2*r)
 plot(xn(i:i+2*r),'b');
end
hold off
grid on 
SNR_target = 10; % SNR in dB

zn = randn(size(xn)); % White Gaussian random noise
%Signal power
P_xn = var(xn); % relies on the ergodicity of the signal model 
% P_xn = mean(abs(xn).^2); % exact power for this realization
%Noise power
P_zn = var(zn); % relies on the ergodicity of the signal model
noise_scaling_factor = sqrt(P_xn/P_zn/10^(SNR_target/10));
% Noisy signal
yn = xn + noise_scaling_factor*zn;
% Make sure that the SNR is OK (just in case…):
P_zn_scaled = var(noise_scaling_factor*zn);
SNR_check = 10*log10(P_xn/P_zn_scaled); 
fftsize = 2048; Fp = fft(p,fftsize);                         
% % DFT of x, saved to Fx  
Np = length(p); Fo = 1/(Ts*Np);                       
% % frequency resolution  
freq2 = -fftsize/2*Fo:Fo:(fftsize/2-1)*Fo;     
% % Two-sided frequency Axis  
% figure
% plot(0:Ts:199*Ts,p(1:200)); % Plotting a piece of the generated signal
% xlabel('Time [s]')
% ylabel('Amplitude') 
figure 
plot(freq2,fftshift(abs(Fp)/Np))    
% % Two-sided amplitude Spectrum
 title('Spectrum of p(t)')
  xlabel('f [MHz]')
  ylabel('Amplitude [-]')
figure
stem(1:length(p),p)
title('Spectrum of p(t)')
  xlabel('f [MHz]')
  ylabel('Amplitude [-]')