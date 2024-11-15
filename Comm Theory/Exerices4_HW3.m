training_signal = zeros(size(1:r*length(training_symbols))); % Zero vector initilized for Up-sampled symbol sequence
training_signal(1:r:r*length(training_symbols)) = training_symbols;

[corr_fun, delay] = xcorr(X_LP_received,training_signal); %cross-correlation
figure
plot(delay,abs(corr_fun))
xlabel('Delay [samples]')
ylabel('Correlation')
title('Cross-correlation between transmitted and received training symbols')
% Find the sample index with the maximum correlation value:
[~, max_ind] = max(abs(corr_fun));
%Estimated delay: The 1st signal sample should be taken at "timing_ind+1"
timing_ind = delay(max_ind);
RX_symbol_frame = X_LP_received(timing_ind+1:r:end);

channel_estimate = RX_training_symbols*training_symbols'/norm(training_symbols)^2; %help norm
RX_data_symbols = RX_data_symbols/channel_estimate;