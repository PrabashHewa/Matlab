clear;
close all;
clc;
addpath('data/');


c = physconst('LightSpeed');

%% SDR parameters

filename = 'MeasuredData.dat'; % File name 
fileID = fopen(filename,'r'); 
dataArray = textscan(fileID,'%f'); 
fclose(fileID); 
radarData = dataArray{1}; 
clearvars fileID dataArray ans; 
  
fc = 5.8*1e9;                             % Center frequency 
Tsweep = input("Sweep Duration(ms) :");  % Sweep time in ms 
NTS = radarData(3);                      % Number of time samples per sweep 
Bw = input("Bandwidth(MHz) :");          % FMCW Bandwidth. 
Data = radarData(5:end);    % raw data in I+j*Q format 
Data_1 = Data(1:2:end);     % Data of channel 1  
Data_2 = Data(2:2:end);     % Data of channel 2
recorded_time = 5;          % seconds

%% Range profile processing
% In this exercise, we only process the data received by the first channel

% Calculate number of sweeps contained in the recorded data
numberSweeps = length(Data_1)/NTS;
psd_matrix = zeros(513,2500);

% Create a loop to process each sweep
for index = 0:1:(numberSweeps-1)
    

    signal = Data_1(NTS*index+1:NTS*index+NTS);
    signal = signal.*hamming(NTS);
    FFT_size = 1024;
    samp_rate = NTS*1e3/Tsweep;
    fsignal = fft(signal, FFT_size);
    psdx = abs(fsignal(1:FFT_size/2+1)).^2/length(fsignal); 
    psdx(2:end-1) = 2*psdx(2:end-1);
    psd = 10*log10(psdx);     
   
    % Obtain the range vector
    Rng = c*linspace(0, samp_rate, FFT_size/2+1)/2*(Tsweep*1e-3)/(2*Bw); 
    psd_matrix(:,index+1) = psd;
    
    % Plot the range profile response (Intensity (dB) vs. Distance (m))
    figure(1)
    plot(Rng,psd)
    xlim([0 50])
    ylim([10 90])
    xlabel('Distance (m)')
    ylabel('Intensity (dB)')
    drawnow
 %%   
    % Plot the range profile response (Intensity (dB) vs Distance (m))
%     if index == 0
%         figure(2)
%         plot(Rng, psd)
%         xlim([0 50])
%         ylim([10 90])
%         xlabel('Distance (m)')
%         ylabel('Intensity (dB)')
%         title("Range profile at the start")
%     elseif index==numberSweeps-1
%         figure(3)
%         plot(Rng,psd)
%         xlim([0 50])
%         ylim([10 90])
%         xlabel('Distance (m)')
%         ylabel('Intensity (dB)')
%         title("Range profile at the end(Target moved farther away)")
%     end
end
