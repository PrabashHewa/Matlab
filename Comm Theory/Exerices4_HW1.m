alphabet_size = 64;
% Number of symbols in the QAM alphabet (e.g. 16 means 16-QAM). Valid alphabet
% sizes are 4, 16, 64, 256, 1024, ... (i.e. the possible values are given
% by the vector 2.^(2:2:N), for any N)
SNR = 10; % Signal-to-noise power ratio [dB]
T = 1/10e6; % Symbol time interval [s]
fc = 75e6; % Carrier frequency
r = 20; % Oversampling factor (r samples per pulse)
N_symbols_per_pulse = 30; % Duration of TX/RX-filters in numbers of symbols
alfa = 0.25; % Roll-off factor (excess bandwidth)

Fs = r/T; % Sampling frequency
Ts = 1/Fs; % Sampling time interval
N_data_symbols = 10000; % Number of data symbols
N_training_symbols = 940; % Number of training symbols

qam_axis = -sqrt(alphabet_size)+1:2:sqrt(alphabet_size)-1;
alphabet = bsxfun(@plus,qam_axis',1j*qam_axis); 
%%% equivalent to alphabet = repmat(qam_axis', 1, sqrt(alphabet_size)) +
repmat(1j*qam_axis, sqrt(alphabet_size), 1); %%%
alphabet = alphabet(:).'; % alphabet symbols as a row vector
% Scaling the constellation, so that the mean power of a transmitted symbol
% is one (e.g., with QPSK this is 1/sqrt(2), and for 16-QAM 1/sqrt(10))
alphabet_scaling_factor = 1/sqrt(mean(abs(alphabet).^2));
alphabet = alphabet*alphabet_scaling_factor;
% Random vector of symbol indices (i.e., numbers between 1...alphabet_size)
symbol_ind = randi(length(alphabet),1,N_data_symbols);
data_symbols = alphabet(symbol_ind); % Data symbols to be transmitted
figure
plot(data_symbols,'bo')
xlabel('Re')
ylabel('Im')
title('Transmitted data symbols')

% Generation of training symbols (similar to data symbols):
training_symbols = alphabet(randi(length(alphabet),1,N_training_symbols));
% Concatenating the training and data symbols to get the overall
% transmitted symbols:
symbol_frame = [training_symbols data_symbols];
%%
p = rcosdesign(alfa,N_symbols_per_pulse,r,'sqrt');
figure
plot(-N_symbols_per_pulse*r/2*Ts:Ts:N_symbols_per_pulse*r/2*Ts,p,'b')
hold on
plot(-N_symbols_per_pulse*r/2*Ts:T:N_symbols_per_pulse*r/2*Ts,p(1:r:end),'ro')
xlabel('time [s]')
xlabel('Amplitude')
title('Transmit/receive RRC filter (pulse shape)')
legend('Pulse shape','Ideal symbol-sampling locations')

symbols_upsampled = zeros(size(1:r*length(symbol_frame))); % Zero vector initilized for Up-sampled symbol sequence
symbols_upsampled(1:r:r*length(symbol_frame)) = symbol_frame;
% I.e. now the up-sampled sequence looks like {a1 0 0... a2 0 0... a3 0 0...}
x_LP = filter(p,1,symbols_upsampled); % Transmitter filtering
x_LP = x_LP(1+(length(p)-1)/2:end); % Filter delay correction
%notice the here x_LP is the complex-valued lowpass equivalent signal of the transmitted real-valued bandpass signal x_BP (generated in the next stage)

% Time vector for the TX oscillator signal:
% t_TX_oscillator = 0:Ts:Ts*(length(x_LP)-1);
TX_clock_start_time = rand; % Clock start time in the TX oscillator
t_TX_oscillator = TX_clock_start_time + (0:Ts:Ts*(length(x_LP)-1));
% TX oscillator signal:
 TX_oscillator_signal = exp(1j*2*pi*fc*t_TX_oscillator);
% TX_oscillator_signal = exp(1j*2*pi*fc*TX_clock_start_time);
% Carrier modulation / upconversion (still complex valued):
x_BP_complex = x_LP.*TX_oscillator_signal;

% Taking the real value to finalize the lowpass-to-bandpass transformation:
x_BP = sqrt(2)*real(x_BP_complex);

figure % zoom manually to see the signal better
plot(t_TX_oscillator, abs(x_LP))
xlabel('Time [s]')
ylabel('Amplitude (of a complex signal)')
title('Lowpass signal in time domain')
figure % zoom manually to see the signal better
plot(t_TX_oscillator, x_BP) %notice no abs needed
xlabel('Time [s]')
ylabel('Amplitude')
title('Bandpass signal in time domain')
NFFT = 2^14; %FFT size
f = -Fs/2:1/(NFFT*Ts):Fs/2-1/(NFFT*Ts);%frequency vector
figure
plot(f/1e6, fftshift(abs(fft(x_LP,NFFT))))
xlabel('Frequency [MHz]')
ylabel('Amplitude ')
title('Amplitude spectrum of the lowpass signal')
figure
plot(f/1e6, fftshift(abs(fft(x_BP_complex,NFFT)))) %notice no abs needed
xlabel('Frequency [MHz]')
ylabel('Amplitude')
title('Amplitude spectrum of the bandpass signal')
figure
plot(f/1e6, fftshift(abs(fft(x_BP,NFFT)))) %notice no abs needed
xlabel('Frequency [MHz]')
ylabel('Amplitude')
title('Amplitude spectrum of the bandpass signal')
%%
delay = randi(940) % Delay in samples
x_BP = [zeros(1,delay), x_BP];