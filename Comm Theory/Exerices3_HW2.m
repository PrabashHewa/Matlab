r = 3; % Oversampling factor
T = 1e-6; % Symbol time interval [s].
Fs = r/T; % Sampling frequency
Ts = 1/Fs; % Sampling time
t = -5*T:Ts:5*T; % Time vector (sampling intervals) for one pulse
alfa = 0.3; % Roll-off factor 
% Raised-Cosine FIR filter:
p = sinc(t/T).*((cos(alfa*pi*t/T))./(1-((2*alfa*t/T).^2)));
figure
plot(t,p)
hold on
stem(t,p)
xlabel('Time [s]')
ylabel('Amplitude')
hold off 
% Zero vector initialized for Up-sampled symbol sequence
symbol_upsampled = zeros(size(1:r*N_symbols));
% Up-sampled sequence, i.e. a1, 0, 0, a2, 0, 0, a3, 0, 0, a4, 0, ...
symbol_upsampled(1:r:r*N_symbols) = symbols;
% Transmitter filtering
xn = filter(p,1,symbol_upsampled);
% Remove filter delay. In general it is the sample index of the the maximum
% value of the impulse response. Thus, check "figure,stem(1:length(p),p)",
% where the maximum is at the 16th sample. Thus, the first symbol
% corresponds the 16th sample
figure
stem(1:length(p),p)
filter_delay = (length(p)-1)/2;
xn = xn(filter_delay+1:end); 
figure
plot(0:Ts:199*Ts,xn(1:200)); % Plotting a piece of the generated signal
xlabel('Time [s]')
ylabel('Amplitude') 

