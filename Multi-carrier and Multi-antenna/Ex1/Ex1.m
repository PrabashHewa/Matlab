%In this script you are expected to implement an OFDM transmitter. The OFDM
%signal will be made up of 300 active subcarriers with a subcarrier spacing
%of 15 KHz. Assume that each subcarrier carries a 16-QAM symbol.
%Furthermore you will need to add a CP of 1/4 times the length of the
%useful symbol duration.

%You will need to use the following Matlab functions:

%-randi()
%-qammod()
%-ifft()

%If you are not familiar with those functions type help "name of the
%function" e.g., help randi

clear 
close all
clc

%% Start by definining the system parameters.

%To create an OFDM signal you need to define:

%-The number of active subcarriers

%-The subcarrier spacing

%-The size of the IFFT block

%-The sampling frequency of your signal

%-You also need to define the modulation order of the information symbols
%that will be transported on each subcarrier and how many symbols you want
%to generate.


%% Generate the QAM symbols

%In order to generate QAM symbols you can use the function "qammod", where
%you will need to indicate the "bit stream" that you want to map
%into the QAM symbols, and the modulation order. The bit stream is a vector
%of numbers ranging from 0 to the modulation order -1, e.g., for 16-QAM
% a vector containing numbers from 0 to 15. to generate the random vector
%use the randi function.


%When you have generated the QAM symbols you can see the constelation by
%writing the name of the variable storing your QAM symbols in real() and
%imag()in the plot below.
figure;
scatter(real('insert your QAM symbols here'), imag('insert your QAM symbols here'))
xlabel('I Branch')
ylabel('Q Branch')
%% Map the information symbol to the active subcarriers, add the zero padding to the rest subcarriers and perform the OFDM modulation.

%Once we have the information symbols we need to map them onto their
%respective subcarriers. Since the size of the IFFT block is larger than
%the number of active subcarriers you will need to add the zero-padding. In
%matlab, the zero padding must be added in the middle of the vector, e.g.,
%data, data, data, ..., data, zero, zero, zero, ..., zero, data, data, data, ..., data.
%this is done like this because of the way IFFT indices are defined in the
%ifft() function.

%Example: given three row vectors a = [1 2 3], b = [4 5 6] and c = [7 8 9]
%you can concatenate them as follows: d = [b a c] = [4 5 6 1 2 3 7 8 9], if
% a, b and c were column vectors d = [b; a; c] = [4; 5; 6; 1; 2; 3; 7; 8; 9]

%Once we have mapped the symbols you can generate the ofdm signal with the
%function ifft


%% Add the CP to the resulting OFDM symbol.
%Add the CP. First of all you will need to figure out how many samples the
%length of 1/4 of the useful symbol duration corresponds to. 

%Choose the right samples for the CP from the OFDM symbol and add them at
%the right place.


%% Plot the spectrum of the OFDM signal

%Now it is time to check whether the waveform that we have genrated looks
%like an OFDM signal. In order to do so you just have to insert your OFDM
%symbol in the code below 

OFDM_freq = fftshift(fft('write your OFDM symbol here',2048));
OFDM_freq = OFDM_freq/rms(OFDM_freq);
Fs = % write your sampling frequency here
freq_axis = -(Fs/2):Fs/length(OFDM_freq):Fs/2-Fs/length(OFDM_freq);
freq_axis = freq_axis/1e6;
plot(freq_axis, 10*log10(OFDM_freq.*conj(OFDM_freq)))
ylim([-60 15])
xlim([-8 8])
xlabel('MHz')
grid on
