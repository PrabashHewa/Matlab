clear;
close all;
clc;
addpath('data/');


c = physconst('LightSpeed');

%% SDR parameters

filename = 'Meas_3.dat'; % File name 
fileID = fopen(filename,'r'); 
dataArray = textscan(fileID,'%f'); 
fclose(fileID); 
radarData = dataArray{1}; 
clearvars fileID dataArray ans; 
  
fc = radarData(1);          % Center frequency 
Tsweep = radarData(2)*1e-3;      % Sweep time in ms 
NTS = radarData(3);         % Number of time samples per sweep 
Bw = radarData(4);          % FMCW Bandwidth. For FSK, it is frequency step;  For CW, it is 0. 
Data = radarData(5:end);    % raw data in I+j*Q format 
Data_1 = Data(1:2:end);     % Data of channel 1  
Data_2 = Data(2:2:end);     % Data of channel 2
lambda=c/fc;          % seconds
%%

samp_rate=NTS/Tsweep;
FFT_size=1024;
dopp_FFT_size=128;
numberSweeps = length(Data_1)/NTS;
data_block1=reshape(Data_1,[NTS,numberSweeps]);

Rng = c*linspace(0, samp_rate, FFT_size/2+1)/2*(Tsweep*1e-3)/(2*Bw); 
psd_matrix=zeros(FFT_size/2+1,numberSweeps);
data_matrix=zeros(FFT_size/2+1,numberSweeps);
t=(1:numberSweeps)*Tsweep;

for index=1:numberSweeps
    signal=data_block1(:,index);
    signal=signal.*hamming(NTS);
    fsignal1 = fft(signal, FFT_size);
    fsingal=fsignal1(1:FFT_size/2+1);
    data_matrix(:,index)=fsingal;
    psdx=(1/length(fsingal)).*abs(fsingal).^2;
     psd = 10*log10(psdx); 
     psd_matrix(:,index) = psd;

end

figure(1)
surf(Rng,t,psd_matrix')
xlim([0 50])
ylim([0 10])
bar=colorbar('EastOutside');
shading interp
colormap(jet)
caxis([30 80])
view(2)
xlabel('Distance (m)')
ylabel('Intensity (dB)')
ylabel(bar,'Normalized intenstiy(dB)','FontName','Arial','FontSize',12)
title('Range Waterfall')

%%
vel_vector=linspace(-1/(2*Tsweep),1/(2*Tsweep),dopp_FFT_size)*lambda/2;
PN=30;
pro_vel_prof=round(numberSweeps/PN);
psd_rng_vel=zeros(pro_vel_prof,length(Rng),dopp_FFT_size);
psd_vel=zeros(pro_vel_prof,dopp_FFT_size);

for index=0:1:(pro_vel_prof-1)

    signal=data_matrix(:,PN*index+1:PN*(index+1));
    window=hamming(PN).';
    window_matrix=repmat(window,length(signal(:,1)),1);
    signal=signal.*window_matrix;

    fsingal=fft(signal,dopp_FFT_size,2);
    psdx=(1/length(fsingal)).*abs(fsingal).^2;
    psdx=fftshift(psdx,2);

    psd_rng_vel(index+1,:,:)=10*log10(psdx);

    plot_image(:,:)=psd_rng_vel(index+1,:,:);
    psd_vel(index+1,:)=mean(plot_image,1);
    figure(2)
    surf(-vel_vector,Rng,plot_image)
    xlim([-6 6])
    ylim([0 100])
    colorbar('EastOutside');
    shading interp
    colormap(jet)
    caxis([0 100])
    view(2)
    xlabel('Velocity (m/s)')
    ylabel('Range (m)')

end

wfall_t=linspace(0,Tsweep*numberSweeps,pro_vel_prof);
figure(3)
surf(-vel_vector,wfall_t,psd_vel)
xlim([-6 6])
ylim([0 10])
bar=colorbar('EastOutside');
colormap(jet)
shading interp
caxis([0 100])
view(2)
xlabel('Velocity (m/2)')
ylabel('Range (m)')

%%
Fc=5.8e9;
Sps=512;
Fs=2*Bw;

t=0:1/Fs:Tsweep-1/Fs;
y=chirp(t,0,Tsweep,Bw,'linear',0);

figure(4)
subplot(211)
plot(t,real(y));
xlabel('Time(s)')
ylabel('Amplitude')
title('FMCW Signal')

subplot(212)
spectrogram(y,1024,0,1024,Fs)
xlabel('Frequency(MHz)')
ylabel('Time(s)')
title('Spectrum of FMCW')
%%

f1=10e6;
f2=50e6;
t=0:1/Fs:Tsweep-1/Fs;
bits=randi([0 1],numel(t)/10,1);
bits=repmat(bits,1,10).';
bits=bits(:);

y=zeros(size(bits));

for ii=1:length(y)
    if bits(ii)==1
        y(ii)=exp(1j*2*pi*f1*t(ii));
    else
        y(ii)=exp(1j*2*pi*f2*t(ii));
    end
end

figure(5)
subplot(211)
plot(t,bits);
xlabel('Time(s)')
ylabel('Amplitude')
title('Digital Signal')
xlim([0 2.5e-6])
ylim([0 1])

subplot(212)
plot(t,real(y));
xlabel('Time(s)')
ylabel('Amplitude')
title('Digital Signal')
xlim([0 2.5e-6])
ylim([0 1])

