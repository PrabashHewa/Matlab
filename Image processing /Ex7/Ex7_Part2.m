
lena = imread('lena.jpg');

gaussian_noise = imnoise(lena, 'gaussian', 0, 0.05);
salt_pepper_noise = imnoise(lena, 'salt & pepper', 0.05);
height = size(lena, 1);
width = size(lena, 2);
b = 0.05;
rayleigh_noise = sqrt(-b * log(1 - rand(height, width)));
rayleigh_noisy_image = lena + uint8(rayleigh_noise.*255);


%% Noise Filters 
% For Gaussian noise
arithmetic_mean_filtered_gaussian = uint8(imfilter(gaussian_noise, fspecial('average', [5 5])));
geometric_mean_filtered_gaussian = uint8(exp(imfilter(log(double(gaussian_noise) + eps), ones(5, 5), 'replicate')).^(1/25));
harmonic_mean_filtered_gaussian = uint8((25) ./ imfilter(1 ./ (double(gaussian_noise) + eps), ones(5, 5), 'replicate'));

% For Salt and Pepper noise
arithmetic_mean_filtered_sp = uint8(imfilter(salt_pepper_noise, fspecial('average', [5 5])));
geometric_mean_filtered_sp = uint8(exp(imfilter(log(double(salt_pepper_noise) + eps), ones(5, 5), 'replicate')).^(1/25));
harmonic_mean_filtered_sp = uint8((25) ./ imfilter(1 ./ (double(salt_pepper_noise) + eps), ones(5, 5), 'replicate'));

% For Rayleigh noise
arithmetic_mean_filtered_rayleigh = uint8(imfilter(rayleigh_noisy_image, fspecial('average', [5 5])));
geometric_mean_filtered_rayleigh = uint8(exp(imfilter(log(double(rayleigh_noisy_image) + eps), ones(5, 5), 'replicate')).^(1/25));
harmonic_mean_filtered_rayleigh = uint8((25) ./ imfilter(1 ./ (double(rayleigh_noisy_image) + eps), ones(5, 5), 'replicate'));

%% Noise Plots 

figure;
subplot(2, 2, 1);
imshow(lena);
title('Original Image');

subplot(2, 2, 2);
imshow(gaussian_noise);
title('Gaussian Noise');

subplot(2, 2, 3);
imshow(salt_pepper_noise);
title('Salt Pepper Noise');

subplot(2, 2, 4);
imshow(rayleigh_noisy_image);
title('Rayleigh Noise');

%% Salt & Pepper noise filter plots
% Display the results
figure;
subplot(2, 2, 1);
imshow(salt_pepper_noise);
title('Salt Pepper Noise')

subplot(2, 2, 2);
imshow(arithmetic_mean_filtered_sp);
title('Arithmetic Mean Filter (Salt & Pepper)')

subplot(2, 2, 3);
imshow(harmonic_mean_filtered_sp);
title('Harmonic Mean Filter (Salt & Pepper)');

subplot(2, 2, 4);
imshow(geometric_mean_filtered_sp);
title('Geometric Mean Filter (Salt & Pepper)');
%% Rayleigh noise filter plots
figure;
subplot(2, 2, 1);
imshow(rayleigh_noisy_image);
title('Rayleigh Noise');

subplot(2, 2, 2);
imshow(harmonic_mean_filtered_rayleigh);
title('Harmonic Mean Filter (Rayleigh');

subplot(2, 2, 3);
imshow(arithmetic_mean_filtered_rayleigh);
title('Arithmetic Mean Filter (Rayleigh)');

subplot(2, 2, 4);
imshow(geometric_mean_filtered_rayleigh);
title('Geometric Mean Filter (Rayleigh)');

%% Gaussian noise filter plots
figure;
subplot(2, 2, 1);
imshow(gaussian_noise);
title('Gaussian Noise');

subplot(2, 2, 2);
imshow(arithmetic_mean_filtered_gaussian);
title('Arithmetic Mean Filter (Gaussian)');

subplot(2, 2, 3);
imshow(geometric_mean_filtered_gaussian);
title('Geometric Mean Filter (Gaussian)');

subplot(2, 2, 4);
imshow(harmonic_mean_filtered_gaussian);
title('Harmonic Mean Filter (Gaussian');





