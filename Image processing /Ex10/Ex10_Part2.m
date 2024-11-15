%% Part a
rgb_image = imread('lena.tiff');
hsi_image = rgb2hsi(rgb_image);

figure(1);

subplot(2,3,1), imshow(rgb_image(:,:,1)), title('R (RGB)');
subplot(2,3,2), imshow(rgb_image(:,:,2)), title('G (RGB)');
subplot(2,3,3), imshow(rgb_image(:,:,3)), title('B (RGB)');

subplot(2,3,4), imshow(hsi_image(:,:,1)), title('H (HSI)');
subplot(2,3,5), imshow(hsi_image(:,:,2)), title('S (HSI)');
subplot(2,3,6), imshow(hsi_image(:,:,3)), title('I (HSI)');

%% Part b

lena_noisy_green = rgb_image;
lena_noisy_green(:,:,2) = imnoise(lena_noisy_green(:,:,2), 'gaussian');


lena_noisy_green_hsi = rgb2hsi(lena_noisy_green);


figure;
subplot(2, 3, 1), imshow(lena_noisy_green(:,:,1)), title('R (Noisy Green)');
subplot(2, 3, 2), imshow(lena_noisy_green(:,:,2)), title('G (Noisy Green)');
subplot(2, 3, 3), imshow(lena_noisy_green(:,:,3)), title('B (Noisy Green)');

subplot(2, 3, 4), imshow(lena_noisy_green_hsi(:,:,1)), title('H (Noisy Green HSI)');
subplot(2, 3, 5), imshow(lena_noisy_green_hsi(:,:,2)), title('S (Noisy Green HSI)');
subplot(2, 3, 6), imshow(lena_noisy_green_hsi(:,:,3)), title('I (Noisy Green HSI)');

%% Part c

noisy_all = imnoise(rgb_image, 'gaussian');


noisy_all_hsi = rgb2hsi(noisy_all);

figure(3);

subplot(2,3,1), imshow(noisy_all(:,:,1),[]), title('Noisy R (RGB)');
subplot(2,3,2), imshow(noisy_all(:,:,2),[]), title('Noisy G (RGB)');
subplot(2,3,3), imshow(noisy_all(:,:,3),[]), title('Noisy B (RGB)');

subplot(2,3,4), imshow(noisy_all_hsi(:,:,1),[]), title('H (HSI)');
subplot(2,3,5), imshow(noisy_all_hsi(:,:,2),[]), title('S (HSI)');
subplot(2,3,6), imshow(noisy_all_hsi(:,:,3),[]), title('I (HSI)');

%% Part d

filtered_hsi = hsi_image;
filtered_hsi(:,:,3) = imfilter(filtered_hsi(:,:,3), fspecial('average'));

filtered_rgb = hsi2rgb(filtered_hsi);

figure(4);
subplot(1, 2, 1), imshow(filtered_rgb), title('Filtered RGB');
subplot(1, 2, 2), imshow(filtered_hsi(:,:,3)), title('Filtered I (HSI)');