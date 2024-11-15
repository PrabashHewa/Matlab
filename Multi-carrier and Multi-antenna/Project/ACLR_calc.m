function [ACLR_r, ACLR_l] = ACLR_calc(signal,BW,SystemFs)

if BW == 1.4e6
    BW0 = 1.08e6;
else
    BW0 = 9/10*BW;
end
BW_AC = BW0; % bandwidth of adjacent channel
offset1 = BW; % offset to center of the adjacent channel
f_edges = [-BW0/2, BW0/2, offset1-BW_AC/2, offset1+BW_AC/2, -offset1-BW_AC/2, -offset1+BW_AC/2];
% DFT points corresponding to the edges:
n_e = round((f_edges+SystemFs/2)*length(signal)/SystemFs+1);

Pow_FD = abs(fftshift(fft(signal))).^2;
ACLR_r = 10*log10(mean(Pow_FD(n_e(1):n_e(2)))*BW0) - 10*log10(mean(Pow_FD(n_e(3):n_e(4)))*BW_AC);
ACLR_l = 10*log10(mean(Pow_FD(n_e(1):n_e(2)))*BW0) - 10*log10(mean(Pow_FD(n_e(5):n_e(6)))*BW_AC);
