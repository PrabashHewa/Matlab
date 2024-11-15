function plot_PSD(signal,Fs_final,color)
w = warning ('off','all');
warning(w)
Nfft = 2^12;
PSD = pwelch(signal,kaiser(Nfft,7),Nfft/2,Nfft,Fs_final);
Freq = -Fs_final/2:Fs_final/length(PSD):Fs_final/2-Fs_final/length(PSD);
Freq = Freq/1e6;
plot(Freq,10*log10(fftshift(PSD)),color,'linewidth',1.5)
grid on
set(gca,'FontSize',11)
% title('Welch power spectral density estimate')
xlabel('Frequency (MHz)')
ylabel('Normalized Power (dB)')


