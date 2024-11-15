
I = imread('DIP.jpg');
T = 1; 
a = -0.1; 
b = -0.1; 
[row, col] = size(I);
[u, v] = meshgrid(-row/2:row/2-1, -col/2:col/2-1);

A=pi * (u * a + v * b);
H = (sin(A) .* exp(-1j * A ))./(A+eps);

%H = H / sum(abs(H(:)));
I = imread('DIP.jpg');
F = fft2(double(I));
Fc = fftshift(F);

G = H .* Fc;

gi = ifft2(ifftshift(G));
motion_blurred_image = real(gi);

% Part a
variance = 50;
noise = sqrt(variance) * randn(size(motion_blurred_image));
degraded_image = motion_blurred_image + noise;
%variance = 50;
%degraded_image = imnoise(motion_blurred_image, 'gaussian', 0, variance / 255^2);

% Part b
eps = 1e-3;
inverse_H_degraded = 1./(H + eps);
inverse_G_degraded =  fftshift(fft2(degraded_image))./(H + eps);
restored_inverse_filtered = real(ifft2(ifftshift(inverse_G_degraded)));
%restored_inverse_filtered = (ifft2(ifftshift(inverse_G_degraded)));

% degraded_fft = fft2(degraded_image);
% inverse_filtered_fft = degraded_fft ./ (H + eps);
% inverse_filtered_img = ifft2(ifftshift(inverse_filtered_fft));

% Part c
Sn = fft2(fftshift(noise)); 
Sf = fft2(fftshift(double(I)));
K= Sn/Sf;
%k = 0.01; % adjust 

wiener_filter = 1./(H+eps).* (conj(H).*H)./ ((conj(H).*H) + K);
filtered_image_wiener = wiener_filter.*fftshift(fft2(degraded_image))  ;
wiener_restored_image = real((ifft2(ifftshift(filtered_image_wiener))));

%wiener_restored_image = wiener2(Fc, [3,3]);

% Part d
figure;

subplot(1, 3, 1);
imshow(uint8(degraded_image), []);
title('Degraded Image');

subplot(1, 3, 2);
imshow(restored_inverse_filtered, []);
title('Restored (Inverse Filtering)');

% subplot(1,3,2);
% imshow(abs(inverse_filtered_img), []);
% title('Inverse Filtering Result');

subplot(1, 3, 3);
imshow(wiener_restored_image, []);
title('Restored (Wiener Filtering)');



%Part f
k_values = [0.85, 0.75, 0.65];

figure;

for i = 1:length(k_values)
    K = k_values(i);
    
    wiener_filter = conj(H) ./ (abs(H).^2 + K);
    G_wiener =  wiener_filter.* fftshift(fft2(degraded_image)) ;
    wiener_restored_image = real(ifft2(ifftshift(G_wiener)));
    
    subplot(1, length(k_values), i);
    imshow(abs(wiener_restored_image), []);
    title(['K = ' num2str(K)]);
end

% Simple inverse filtering amplifies high-frequency components, which
% results in increased noise.This makes the inverse filtering approach
% sensitive to noise, leading to a poor restoration.
