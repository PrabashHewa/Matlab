%In this script you are expected to implement an OFDM transmitter and its
%corresponding receiver.

%The OFDM signal will be made up of 300 active subcarriers with a subcarrier spacing
%of 15 kHz. Assume that each subcarrier carries a BPSK symbol.
%Furthermore you will need to add a CP with a duration of 1.6667*10^-5
%seconds.

%Once  that you have implemented the transmitter and generated the OFDM
%signal. You have to pass the signal through an ideal channel with impulse
%response delta(t).

%To be able to demodulate and recover the information bits from the signal
%at the channel output, you will have to implement the corresponding OFDM
%receiver. You basically have to undo all the block of the transmitter but
%in the other way around.

%You will need to use the following Matlab functions:

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

%% Copy here the code of the first matlab exercise, your own code or the model solution.

%% Transmission over the ideal channel

Channel = 1;

%Since the IFFT output is a time domain signal, the output of the channel
%is given by the convolution/filtering between the signal and the channel.
%Put your OFDM symbol where it says channel_input
channel_output = filter(Channel,1,channel_input);

%% Receiver Implementation

%Remove the CP from the received signal

%Perform the OFDM demodulation

%Select the right FFT bins that are carrying our information symbols. This
%basically means to remove the zero padding.

%Demodulate the BPSK symbols

%Check if the transmit bit sequence corresponds to the received sequence.
