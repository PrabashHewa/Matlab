clear
close all
clc

%% Start by definining the system parameters.


%% Generate the QAM symbols


%% Generate the Pilot symbols


%% Frame Generation

%Something similar to the line below should work. Be careful with row/column
%vectors. The variables in the brackets are the corresponding OFDM symbols.

% frame = [pilots info_symbols pilots info_symbols];

%% Map the information symbol to the active subcarriers, add the zero padding to the rest of subcarriers and perform the OFDM modulation.

%OFDM generation


%% Add the CP to the resulting OFDM symbol.


%% Define the channel model

%Multipath components of the channel. This will introduce ISI but the CP
%will cope with it.
Channel1 = [1, 0.6, 0 0.1];
Channel2 = [1, 0.8, 0 0.15];
Channel_Freq_response = fft(Channel1,FFT_size).';
Channel_amplitude = abs(Channel_Freq_response);
Channel_phase = phase(Channel_Freq_response)*180/pi;

Channel2_Freq_response = fft(Channel2,FFT_size).';
Channel2_amplitude = abs(Channel2_Freq_response);
Channel2_phase = phase(Channel2_Freq_response)*180/pi;

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

figure;
stem(Channel2_amplitude,'filled','b')
xlabel('Subcarrier Index')
ylabel('Amplitude')
title('Channel Amplitude Response')
grid on

figure;
stem(Channel2_phase,'filled','r')
xlabel('Subcarrier index')
ylabel('Phase in degrees')
title('Channel Phase Response')
grid on

%% Pass the signal through the channel




%% Add the noise

noise = 1/sqrt(2)*(randn(length(received_signal),1) + 1j*randn(length(received_signal),1));
snr_dB = 40;
snr_lin = 10^(snr_dB/10);
noise = noise/sqrt(snr_lin);

%% Implement the receiver processing

%Remove CP Prefix


%Perform OFDM demodulation


%Drop the zero padding


%% Channel Estimation



%% Calculate the ZF Equalizer coefficients



%% Perform Channel Equalization




%% Plot symbols

% grid_distance =  0.6325;

figure

line([0 0], [-0.3162*8 0.3162*8])
line([-0.3162*8 0.3162*8], [0 0])
xlim([-0.3162*6 0.3162*6])
ylim([-0.3162*6 0.3162*6]), hold off

%% Plot the estimated channel response