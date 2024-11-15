%In this third session we are finally building the whole OFDM link. You
%are expected to implement an OFDM transmitter with 32 active subcarriers,
%BPSK as subcarrier modulation and subcarrier spacing of 15 KHz. This time
%the signal is going to be transmitted through a multipath channel,
%therefore, the resulting received signal at the receiver side is a
%combination of different delay replicas of the original transmitted
%symbol, that is, the multipath channel introduces
%inter-symbol-interference. 

%On the other hand, the multipath channel is frequency selective, and
%therefore, different subcarriers experience different amplitude scalings
%and phase rotations due to the effect of the channel. Your goal is 
%to undo the channel effect by means of a zero-forcing equalizer so that 
%you are able to properly recover the original transmit sequence without
%any mistake.

%Try first with a CP length of a quarter of the duration of the OFDM symbol
% and then with a length of 1/16.


%-randi()
%-qammod()
%-ifft()
%-filter()
%-fft()
%-qamdemod()

%If you are not familiar with those functions type help "name of the
%function" e.g., help randi

clear 
close all
clc

%% Start by definining the system parameters.

%Active subcarriers

%Subcarrier Spacing 15 KHz

%FFT size 

%Sampling Frequency

%Useful symbol duration 

%Modulation order 

%Number_of_symbols


%% Generate the QAM symbols

%Bit generation

%M-QAM modulation

%We need to map the information symbols to the active subcarriers and
% add zero-padding to the rest ones.

%% Map the information symbol to the active subcarriers, add the zero padding to the rest of subcarriers and perform the OFDM modulation.


%OFDM generation


%% Add the CP to the resulting OFDM symbol.


%% Define the channel model

%Multipath components of the channel. This will introduce ISI but the CP
%will cope with it.
Channel = [1, 0.6, 0 0.1];
Channel_Freq_response = fft(Channel,32).';
Channel_amplitude = abs(Channel_Freq_response).^2;
Channel_phase = phase(Channel_Freq_response)*180/pi;

figure;
stem(Channel_amplitude,'filled','b')
xlabel('Subcarrier Index')
ylabel('Amplitude')
title('Channel Amplitude Response')
grid on

figure;
stem(Channel_phase,'filled','r')
xlabel('Subcarrier index')
ylabel('Phase in degrees')
title('Channel Phase Response')
grid on

%% Pass the signal through the channel

received_signal = filter(Channel, 1, 'insert your ofdm symbol with cp');

%Additive white Gaussian noise. Do the implementation without considering
%the noise, once you know that the code is correct and you receive the
%right sequence of BPSK symbols take into account the noise aswell. 
%In order to do so just remove the 0 multiplying the noise at the output channel signal.
noise = 1/sqrt(2)*(randn(length(received_signal),1) + 1j*randn(length(received_signal),1));
snr_dB = 20;
snr_lin = 10^(snr_dB/10);
noise = noise/sqrt(snr_lin)*rms(received_signal);

received_signal = received_signal + 0*noise;
%% Implement the receiver processing

%Remove CP Prefix

%Perform OFDM demodulation

%Drop the zero padding 

%Calculate the ZF Equalizer coefficients

%Perform Channel Equalization


%% Plot symbols


% grid_distance =  0.6325;

figure
scatter(real(transmitted_bpsk_symbols), imag(transmitted_bpsk_symbols),'rx'), hold on
scatter(real('equalized_symbols'), imag('equalized_symbols'),'k')
line([0 0], [-0.3162*5 0.3162*5])
line([-0.3162*5 0.3162*5], [0 0])
xlim([-0.3162*4 0.3162*4])
ylim([-0.3162*4 0.3162*4]), hold off
