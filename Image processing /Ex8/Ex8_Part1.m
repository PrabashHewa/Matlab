
I = imread('DIP.jpg');

% Part a
T = 1; 
a = -0.1; 
b = -0.1; 

[row, col] = size(I);

[u, v] = meshgrid(-row/2:row/2-1, -col/2:col/2-1);

A=pi * (u * a + v * b);
H = (sin(A) .* exp(-1j * A ))./(A+eps);
%H = H / sum(abs(H(:))); % normalize filter

% Part b
F = fft2(double(I));
Fc = fftshift(F);

G = H .* Fc;

gi = ifft2(ifftshift(G));
motion_blurred_image = real(gi);

% Part c
Fh = fft2(motion_blurred_image);
Fch = fftshift(Fh);

eps = 1e-3; 
inverse_H = 1./(H + eps);
inverse_G =  Fch./(H + eps);

inverse_gi = ifft2(ifftshift(inverse_G));
restored_image = real(inverse_gi);

% Part d
figure;

subplot(1, 3, 1);
imshow(I, []);
title('Original Image');

subplot(1, 3, 2);
imshow(motion_blurred_image, []);
title('Motion Blurred Image');

subplot(1, 3, 3);
imshow(restored_image, []);
title('Restored Image');

% Mean Squared Error values
I_double = double(I);
motion_blurred_image_double = double(motion_blurred_image);

mse_motion_blurred = immse(I_double, motion_blurred_image_double);
mse_restored = immse(I_double, restored_image);

fprintf('MSE(Motion Blurred): %f\n', mse_motion_blurred);
fprintf('MSE (Restored): %f\n', mse_restored);
