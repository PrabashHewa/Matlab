n = randn(size(x_BP)); % White Gaussian random noise

P_x_BP = var(x_BP); % Signal power
P_n = var(n); % Noise power
% Defining noise scaling factor based on the desired SNR:
noise_scaling_factor = sqrt(P_x_BP/P_n/10^(SNR/10)*(r/(1+alfa)));

y_BP = x_BP + noise_scaling_factor*n;
%%
%t_RX_oscillator = 0:Ts:Ts*(length(y_BP)-1);
RX_clock_start_time = rand; % Clock start time in the RX oscillator
t_RX_oscillator = RX_clock_start_time + (0:Ts:Ts*(length(y_BP)-1));
RX_oscillator_signal = exp(-1j*2*pi*fc*t_RX_oscillator);
% RX_oscillator_signal = exp(-1j*2*pi*fc*RX_clock_start_time);
y_BP_downconverted = y_BP.*RX_oscillator_signal;
X_LP_received = sqrt(2)*filter(p,1,y_BP_downconverted); % Receiver filtering
X_LP_received = X_LP_received(1+(length(p)-1)/2:end); 
% Filter delay correction
%%
RX_symbol_frame = X_LP_received(1:r:end);

RX_training_symbols = RX_symbol_frame(1:N_training_symbols);
RX_data_symbols = RX_symbol_frame(N_training_symbols+1:end);

figure
plot(RX_data_symbols,'bo')
hold on
plot(alphabet,'rs')
hold off
xlabel('Re')
xlabel('Im')
title('Received data symbols with clock offset (phase error)')
%%
% alphabet_error_matrix = abs(bsxfun(@minus,alphabet.',RX_data_symbols));
% [~,estimated_symbol_ind] = min(alphabet_error_matrix);
% symbol_errors = estimated_symbol_ind ~= symbol_ind(1:length(estimated_symbol_ind));
% 
% SER = mean(symbol_errors)
