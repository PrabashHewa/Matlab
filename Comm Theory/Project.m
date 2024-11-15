Nactive=1200;
%-The subcarrier spacing
fss=15e3;
%-The size of the IFFT block
nIFFT=1024;
Nsym=1;
%-The sampling frequency of your signal
Fs=fss*nIFFT;

Ts = 1/Fs; % sampling interval
Tsym=1/fss; % symbol duration 
Tcp= 0.25* Tsym;
bits = randi([0 3],Nactive,Nsym);
OFDMsymbols = qammod(bits,4,'UnitAveragePower',true);

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
load('Final_OFDM.mat');
Reference_OFDM = signal.';
%pass the signals through the PA
cp_ofdm_symbol=cp_ofdm_symbol(:);
PA_output = PA_model_lab(cp_ofdm_symbol,16);
PA_output_reference = PA_model_lab(Reference_OFDM,16);