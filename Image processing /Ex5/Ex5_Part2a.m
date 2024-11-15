
original_img = imread('cameraman.tif');

max_intensity = 10;
noise = randn(size(original_img)) * max_intensity;
noisy_img = original_img + uint8(noise);

figure;
subplot(1, 2, 1), imshow(original_img), title('Original Image');
subplot(1, 2, 2), imshow(noisy_img), title('Noisy Image');

set(gcf, 'Position', get(0, 'Screensize'));  