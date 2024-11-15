% MATLAB Code
% Generated by MATLAB 9.11 and Radar Toolbox 1.1
% Generated on 14-Sep-2022 10:24:40

% All quantities are in standard units

wavelen = 0.3;							% Wavelength (m)
pwidth = 5e-07;							% Pulse width (s)
sysloss = 2;							% System losses (dB)
noisetemp = 290;						% Noise temperature (K)
rcs1=0.1;
rcs2 = 1;								% Target radar cross section (m^2)
gain = 30;								% Gain (dB)
tgtrng = 25000;							% Target range (m)
pkpow = 5000;							% Peak transmit power (W)

for i = 500:35000
snr1(i) = radareqsnr(wavelen, i, pkpow, pwidth,'rcs', rcs1, 'gain', ...
    gain, 'loss', sysloss, 'Ts', noisetemp);
end

for i = 500:35000
snr2(i) = radareqsnr(wavelen, i, pkpow, pwidth,'rcs', rcs2, 'gain', ...
    gain, 'loss', sysloss, 'Ts', noisetemp);
end

figure
plot(snr1(500:end))
hold on 
plot(snr2(500:end))
hold off
title('SNR Vs Distance');
xlabel('Distance(m)');
ylabel('SNR(dB)');
legend("RCS =0.1m^2","RCS=1m^2");