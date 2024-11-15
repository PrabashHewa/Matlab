clear 
close all
clc

Nactive=128;
%-The subcarrier spacing
fss=15e3;
%-The size of the IFFT block
nIFFT=1024;
Nsym=10;
%-The sampling frequency of your signal
Fs=fss*nIFFT;

Ts = 1/Fs; % sampling interval
Tsym=1/fss; % symbol duration 
Tcp= 0.25* Tsym;
bits = randi([0 3],Nactive,Nsym);
OFDMsymbols = pskmod(bits,4,pi/4);

% figure;
% scatter(real(OFDMsymbols), imag(OFDMsymbols))
% xlabel('I Branch')
% ylabel('Q Branch')

DFT=fft(OFDMsymbols,Nactive);
% DFT-S-OFDM
subcarrier_mapping = [DFT(1:Nactive/2,:);zeros(nIFFT-(Nactive)-1,Nsym);DFT(end-Nactive/2:end-1,:);zeros(1,Nsym)];
DFT_symbol= ifft(subcarrier_mapping,nIFFT);
cp_length_samples = round(Tcp*Fs);
cp = DFT_symbol(end-cp_length_samples+1:end,:); 
dft_s_ofdm = [cp;DFT_symbol];
% figure;
% scatter(real(dft_s_ofdm), imag(dft_s_ofdm))
% xlabel('I Branch')
% ylabel('Q Branch')
% OFDM

subcarrier_mapping = [OFDMsymbols(1:Nactive/2,:);zeros(nIFFT-(Nactive)-1,Nsym);OFDMsymbols(end-Nactive/2:end-1,:);zeros(1,Nsym)];
ofdm_symbol= ifft(subcarrier_mapping,nIFFT);
cp_length_samples = round(Tcp*Fs);
cp = ofdm_symbol(end-cp_length_samples+1:end,:); 
ofdm = [cp;ofdm_symbol];
% figure;
% scatter(real(ofdm), imag(ofdm))
% xlabel('I Branch')
% ylabel('Q Branch')
%% Reference OFDM signal that includes symbol windowing and PAPR reduction.
load('Final_OFDM.mat');
Reference_OFDM = signal.';
%pass the DFT-S-OFDM through the PA
dft_s_ofdm=dft_s_ofdm(:);
PA_output1 = PA_model_lab(dft_s_ofdm,4);
PA_output_dft = PA_model_lab(Reference_OFDM,4);

scaling_factor = sqrt(18*1e6);
figure, hold on
plot_PSD(scaling_factor*dft_s_ofdm/rms(dft_s_ofdm),Fs,'')
plot_PSD(scaling_factor*PA_output1/rms(PA_output1),Fs,'')
% plot_PSD(scaling_factor*Reference_OFDM/rms(Reference_OFDM),122880000,'')
% plot_PSD(scaling_factor*PA_output_dft/rms(PA_output_dft),122880000,''), 
hold off
%pass the OFDM through the PA
ofdm=ofdm(:);
PA_output2 = PA_model_lab(ofdm,4);
PA_output_ofdm = PA_model_lab(Reference_OFDM,4);

scaling_factor = sqrt(18*1e6);
figure, hold on
plot_PSD(scaling_factor*ofdm/rms(ofdm),Fs,'')
plot_PSD(scaling_factor*PA_output2/rms(PA_output2),Fs,'')
% plot_PSD(scaling_factor*Reference_OFDM/rms(Reference_OFDM),122880000,'')
% plot_PSD(scaling_factor*PA_output_ofdm/rms(PA_output_ofdm),122880000,''),
hold off

% ccdf = comm.CCDF('AveragePowerOutputPort',true,'PeakPowerOutputPort',true);
% [ccdfy,ccdfx,papr] = ccdf(dft_s_ofdm) ;
% figure
% semilogy(papr)

% f=ecdf(signal);
% ccdf = 1-f;   %CCDF
% semilogy(ccdf)
% computing the peak to average power ratio for each symbol
meanSquareValue = ofdm.*ofdm'/length(ofdm);
peakValue = max(ofdm.*conj(ofdm));
paprSymbol = peakValue./meanSquareValue;

paprSymboldB = 10*log10(paprSymbol);
% [n,x] = histogram(paprSymboldB,(0:0.5:15));
 [f,x]=ecdf(paprSymboldB);
ccdf = 1.-f;   %CCDF
figure
semilogy(x,ccdf);

% figure
% plot(x,cumsum(n)/nSymbol,'LineWidth',4)
xlabel('papr, x dB')
ylabel('Probability, X <=x')
title('CDF plots of PAPR from an IEEE 802.11a Tx with BPSK modulation')
grid on
