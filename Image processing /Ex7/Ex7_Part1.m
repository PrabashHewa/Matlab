
lena = imread('lena.jpg');

figure;
subplot(2, 2, 1);
imshow(lena);
title('Original Image');

% a) Gaussian noise
gaussian_noise = imnoise(lena, 'gaussian', 0, 0.05);
subplot(2, 2, 2);
imshow(gaussian_noise);
title('Gaussian Noise');

% b) Salt and Pepper noise
salt_pepper_noise = imnoise(lena, 'salt & pepper', 0.05);
subplot(2, 2, 3);
imshow(salt_pepper_noise);
title('Salt and Pepper Noise');

% c) Rayleigh noise
height = size(lena, 1);
width = size(lena, 2);
b = 0.05;
rayleigh_noise = sqrt(-b * log(1 - rand(height, width)));
rayleigh_noisy_image = lena + uint8(rayleigh_noise.*255);
subplot(2, 2, 4);
imshow(rayleigh_noisy_image);
title('Rayleigh Noise');

