clear
close all
clc

%% System parameters
%counter
i = 0;
%flag for the while loop
flag = 1;


%multipath channel 1
Channel1 = [1, 0.6, 0 0.1];

%Channel representation in frequency domain
Active_subcarriers = 32;
Channel_Freq_response = fft(Channel1,Active_subcarriers).';
Channel_amplitude = abs(Channel_Freq_response).^2;
Channel_amplitude2 = abs(Channel_Freq_response).^2;

%Noise power in linear units
Pnoise = 0.25;
%Total power available at the transmitter in linear units
Ptot = 15;
%Number of channels
N = Active_subcarriers;

figure;
stem(Channel_amplitude,'filled','b')
xlabel('Subcarrier Index')
ylabel('Amplitude')
title('Channel Amplitude Response')
grid on

%% Waterfilling algorithm

while flag
    
    
    water_level = Ptot/(N-i) + 1/(N-i)*Pnoise*sum(1./Channel_amplitude);
    
    allocated_power = water_level - Pnoise./Channel_amplitude;
    
    
    if length(find(allocated_power<0))==0 %#ok
        flag = 0;
    else
        i=i+1;
        indice = find(allocated_power < 0);
        Channel_amplitude(indice(1)) = [];
    end
    
    
    
end
%% Plot results
power_allocation = [allocated_power(1:indice(1)+length(indice)-2); zeros(i,1); allocated_power(indice(end):end)]

figure
bar(1:length(power_allocation),power_allocation+Pnoise./Channel_amplitude2,'r'),hold

bar(1:N,Pnoise./Channel_amplitude2,'b'),

plot([0 N+1],[water_level,water_level],'r','LineWidth',4),hold off, grid
xlim([0 Active_subcarriers+1])
xlabel('Subcarrier Index')
ylabel('Power Level')
title('Waterfilling Algorithm')
legend('Allocated Power','Noise Level')


