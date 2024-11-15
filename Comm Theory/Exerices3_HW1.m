alphabet =  [-3 -1 1 3];
N_symbols = 10;
% Random vector that includes integers (=”symbol indices”) between 1 and 4:
symbol_ind = randi(length(alphabet),1,N_symbols);
% I.e., these numbers represent the symbols indices in the alphabet
% (1 means the symbol "-3", 2 means the symbol "-1", and so on...
symbols = alphabet(symbol_ind); % Generate a random symbol sequence
figure
stem(symbols); % Plots the symbol sequence
xlabel('Time [s]')
ylabel('Amplitude') 
%%
r = 10; % samples per pulse/symbol (oversampling factor)
T = 1e-6; % Symbol time interval [s].
Fs = r/T; % Sampling frequency
Ts = 1/Fs; % Sample time interval
t = 0:Ts:N_symbols*T; % Time vector (sampling intervals) for all symbols
% Generation of the pulse:
% Option #1 (traditional)
% p = sinc(t/T); % The pulse given in fixed time vector defined by t
% Option #2 (The pulse given in function defined by the time vector
% parameter t. In Matlab this is called a handle function and it is more
% convenient in our case, so we use it in the following. Here p is not a
% double-variable, but it is a function that can be called any time for
% different time vectors)
p = @(t) sinc(t/T); % Sinc pulse handle function

t_plot = -10e-6:Ts:10e-6; %plot time interval
figure
plot(t_plot,p(t_plot))
xlabel('Time [s]')
ylabel('Amplitude')
grid on
xlim([-10e-6 10e-6]) % x-axis limits
title('Sinc-pulse')

figure
hold on % allows us to plot on top of the previous plots
x = 0; %initialize the sum of pulses (i.e. the total signal x(t))
a = symbols; % Renaming the symbol vector according to the equation notation
% For each symbol index k, we generate the weighted pulse and add it to the
% overall sum defining the PAM signal x
for k = 0:N_symbols-1
 % Remember that Matlab indexing starts from 1 (a_0=a(1), a_1=a(2), etc.)
 kth_pulse = a(k+1)*p(t-k*T); %kth pulse weighted by the symbol a_k

 x = x + kth_pulse; % add the kth pulse to the overall sum (PAM signal) 
 plot(t,kth_pulse,'LineWidth',2)
 % Notice that Matlab changes the line color automatically between plots
end
plot(t,x,'k','LineWidth',3) % Plotting the total signal x with black color
% In the end, we also plot the symbol values in their correct time instants
plot(0:T:T*(N_symbols-1),symbols(1:N_symbols),'ko','MarkerSize',10)
xlabel('Time [s]')
ylabel('Amplitude') 
hold off
grid on 