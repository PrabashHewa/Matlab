%%
N = 10000; % Number of generated samples
noise_var = 3; % Desired noise variance
noise = sqrt(noise_var)*randn(1,N); % Noise signal generation
figure
plot(noise)
xlabel('sample index')
ylabel('noise amplitude')
title('White noise')
xlim([0 100]) %define the x-axis limits
figure
histogram(noise,40)
xlabel('noise amplitude')
ylabel('histogram count')
title('White noise histogram') 
%%
N_filter = 60; %even number
h = firpm(N_filter,[0 0.1 0.2 1],[1 1 0 0]); 
N_freq = length(noise);
freq_vec_filter = -1:2/N_freq:(1-2/N_freq);
%frequency vector values normalized between -1 and 1
figure,plot(freq_vec_filter,10*log10(fftshift(abs(fft(h,N_freq)))))
xlabel('Normalized frequency (F_s/2=1)')
ylabel('Amplitude')
title('Amplitude response of the filter') 

figure
stem(-N_filter/2:N_filter/2,h)
title('Impulse response of the filter')
xlabel('Normalized Frequency')
ylabel('Amplitude Responce')

% Filter the noise signal:
filtered_noise = filter(h,1,noise); 
filtered_noise = filtered_noise(N_filter/2+1:end); %remove the delay
figure
plot(noise(1:N_filter))
hold on
plot(filtered_noise(1:N_filter),'r')
legend('White noise','Colored noise')
xlabel('sample index')
ylabel('noise amplitude')
title('White noise and filtered (colored) noise')

%%
[corr_fun, lags] = xcorr(noise);
% we normalize the max-value to 1 and use stem-function in order to emphasize
% the impulse-like nature of the outcome
figure,stem(lags,corr_fun/max(corr_fun))
xlabel('\tau')
% \tau gives the Greek tau-letter (\ works generally for the Greek alphabet)
ylabel('R(\tau)')
title('Autocorrelation of white noise')
xlim([-30 30]) 

[corr_fun, lags] = xcorr(noise);
figure,plot(lags,corr_fun/max(corr_fun)) 
noise_abs_spec = 20*log10(abs(fft(noise(1:length(filtered_noise))))); 
filtered_noise_abs_spec = 20*log10(abs(fft(filtered_noise)));
%Define the frequency vector values (normalized between -1 and 1):
freq_vec = -1:2/length(noise_abs_spec):1-2/length(noise_abs_spec);
figure
plot(freq_vec,fftshift(noise_abs_spec))
hold on
plot(freq_vec,fftshift(filtered_noise_abs_spec),'r')
hold off
xlabel('Normalized frequency (F_s/2=1)')
ylabel('power [dB]')
title('Noise spectra')
legend('White noise','Filtered (coloured) noise') 
%%
N_samples = 2000; %Number of samples for each realization
N_ensemble = 100; %Number of signal realizations (i.e., the size of ensemble)
%Step probability and step size:
p = 0.5; % P(Wi=s) = p, P(Wi=-s) = 1-p
s = 1; %step length
n = 1:N_samples; % vector of samples indices
% Generating matrix of randomly generated steps:
W = rand(N_ensemble,N_samples);
% (i.e. uniformly distributed random values between 0 and 1)
indices_with_positive_s = W<p; % find out steps going "up"
W(indices_with_positive_s) = s; % Define steps for going "up"
W(~indices_with_positive_s) = -s; % Define steps for going "down"
% The overall "random walk" is achieved by taking the cumulative sum over the
% steps:
X = cumsum(W,2);
% (Notice that now each row describes one random walk realization, so the sum
% is taken over the 2nd dimension)
figure
for ind = 1:5
 subplot(5,1,ind)
 plot(n,X(ind,:))
 xlabel('n')
 ylabel('X(n)')
 grid on
 title(['Realization #' num2str(ind)])
 %num2str converts a numerical value into a character value
end
% Here is a handy way to get a full screen figure
% (otherwise the figure might be to unclear):
%%
set(gcf,'units','normalized','outerposition',[0 0 1 1])
mean_theory = n*s*(2*p-1); % Theoretical mean
var_theory = n*(2*s)^2*p*(1-p); % Theoretical variance
mean_observed = mean(X); % Empirical mean (i.e., what we observe)
var_observed = var(X); % Empirical variance (i.e., what we observe)
figure
plot(n,var_observed,'b','LineWidth',3)
hold on
plot(n,var_theory,'r:','LineWidth',2)
hold off
legend('observed variance ','theoretical variance ')
ylim([-2 2]) % set the axis limits in y-direction only
xlabel('n')
ylabel('variance ')
title('variance  over the sample index')
%
% and the same for the variance…