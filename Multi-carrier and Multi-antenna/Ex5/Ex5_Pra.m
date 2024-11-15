%% Build the OFDM transmitter
%-The number of active subcarriers
Nactive=1200;
%-The subcarrier spacing
fss=15e3;
%-The size of the IFFT block
nIFFT=8192;
Nsym=1;
%-The sampling frequency of your signal
Fs=fss*nIFFT;

Ts = 1/Fs; % sampling interval
Tsym=1/fss; % symbol duration 
Tcp= 0.25* Tsym;
bits = randi([0 63],Nactive,Nsym);
OFDMsymbols = qammod(bits,64,'UnitAveragePower',true);

figure;
scatter(real(OFDMsymbols), imag(OFDMsymbols))
xlabel('I Branch')
ylabel('Q Branch')

subcarrier_mapping = [OFDMsymbols(1:Nactive/2,:);zeros(nIFFT-(Nactive)-1,Nsym);OFDMsymbols(end-Nactive/2:end-1,:);zeros(1,Nsym)];
ofdm_symbol= ifft(subcarrier_mapping,nIFFT);
cp_length_samples = round(Tcp*Fs);
cp = ofdm_symbol(end-cp_length_samples+1:end,:); 
cp_ofdm_symbol = [cp;ofdm_symbol]; 

%% Reference OFDM signal that includes symbol windowing and PAPR reduction.
%Reference_OFDM is a OFDM signal with 1200 active subcarriers that includes
%PAPR reduction and WOLA processing.
load('Final_OFDM.mat');
Reference_OFDM = signal.';

%pass the signals through the PA
cp_ofdm_symbol=cp_ofdm_symbol(:);
PA_output = PA_model_lab(cp_ofdm_symbol,16);
PA_output_reference = PA_model_lab(Reference_OFDM,16);


%calculate ACLR of the PA input and PA output signals.
[ACLR_r, ACLR_l] = ACLR_calc(cp_ofdm_symbol,20*1e6,Fs)
[ACLR_r, ACLR_l] = ACLR_calc(Reference_OFDM,20*1e6,Fs)
[ACLR_r, ACLR_l] = ACLR_calc(PA_output_reference,20*1e6,Fs)

%plot here the spectra of the PA input and PA output signals


scaling_factor = sqrt(18*1e6);
figure, hold on
plot_PSD(scaling_factor*cp_ofdm_symbol/rms(cp_ofdm_symbol),Fs,'')
plot_PSD(scaling_factor*PA_output/rms(PA_output),Fs,'')
plot_PSD(scaling_factor*Reference_OFDM/rms(Reference_OFDM),122880000,'')
plot_PSD(scaling_factor*PA_output_reference/rms(PA_output_reference),122880000,''), hold off

xlim([-40 40])
ylim([-90 10])

figure
scatter(abs(cp_ofdm_symbol), abs(PA_output));
xlabel('In')
ylabel('Out')

%% Build the OFDM receiver for the signal that you generated and plot constellations with and without power amplifier.
%do not demodulate the reference signal as your receiver implementation
%won't work.

%Remove the CP from the received signal (With no power Amp)
Rx_without_cp = cp_ofdm_symbol(end-cp_length_samples+1:end,:);

%Perform the OFDM demodulation
OFDM_Demod = fft(Rx_without_cp,nIFFT);

% remove the zero padding.
Rx_Symbols_NAMP = [OFDM_Demod(1:Nactive/2,:);OFDM_Demod(end-Nactive/2+1:end,:)];

%Remove the CP from the received signal(With power Amp)
Rx_without_cp = PA_output(end-cp_length_samples+1:end,:);

%Perform the OFDM demodulation
OFDM_Demod = fft(Rx_without_cp,nIFFT);

% remove the zero padding.
Rx_Symbols_AMP = [OFDM_Demod(1:Nactive/2,:);OFDM_Demod(end-Nactive/2+1:end,:)];

figure
scatter(real(Rx_Symbols_AMP), imag(Rx_Symbols_AMP),'rx'), hold on
scatter(real(Rx_Symbols_NAMP), imag(Rx_Symbols_NAMP),'k')
line([0 0], [-0.3162*5 0.3162*5])
line([-0.3162*5 0.3162*5], [0 0])
xlim([-0.3162*4 0.3162*4])
ylim([-0.3162*4 0.3162*4]), hold off

