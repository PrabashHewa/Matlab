% a) Load RGB image and convert to YCbCr colorspace
lena_rgb = imread('lena.tiff');
lena_ycbcr = rgb2ycbcr(lena_rgb);

% Display Y, Cb, and Cr 
figure;
subplot(1, 3, 1), imshow(lena_ycbcr(:, :, 1)), title('Y Component');
subplot(1, 3, 2), imshow(lena_ycbcr(:, :, 2)), title('Cb Component');
subplot(1, 3, 3), imshow(lena_ycbcr(:, :, 3)), title('Cr Component');

% b) Subsampling of chrominance and luminance components
subsampling_factors = [2, 1, 2]; % Change as needed

Y_subsampled = lena_ycbcr(:, :, 1);
Cb_subsampled = lena_ycbcr(:, 1:subsampling_factors(1):end, 2);
Cr_subsampled = lena_ycbcr(:, 1:subsampling_factors(1):end, 3);

% c) Upsample components back to original resolution and convert to RGB
Cb_upsampled = imresize(Cb_subsampled, size(Y_subsampled), 'nearest');
Cr_upsampled = imresize(Cr_subsampled, size(Y_subsampled), 'nearest');

% Recombine 
lena_subsampled_ycbcr = cat(3, Y_subsampled, Cb_upsampled, Cr_upsampled);

%  YCbCr  to RGB
lena_subsampled_rgb = ycbcr2rgb(lena_subsampled_ycbcr);
lena_rgb_upsampled_422 = ycbcr2rgb(lena_upsampled_422);
lena_rgb_upsampled_411 = ycbcr2rgb(lena_upsampled_411);
lena_rgb_upsampled_420 = ycbcr2rgb(lena_upsampled_420);

figure;
subplot(2, 3, 1), imshow(lena_rgb), title('Original');
subplot(2, 3, 2), imshow(lena_subsampled_rgb), title('4:2:2 Subsampled');
subplot(2, 3, 3), imshow(lena_subsampled_rgb), title('4:1:1 Subsampled');
subplot(2, 3, 4), imshow(lena_subsampled_rgb), title('4:2:0 Subsampled');
subplot(2, 3, 5), imshow(lena_subsampled_rgb), title('4:1:1 Subsampled');

% d) MSE
mse_422 = immse(lena_rgb, lena_subsampled_rgb_422);
mse_411 = immse(lena_rgb, lena_subsampled_rgb_411);
mse_420 = immse(lena_rgb, lena_subsampled_rgb_420);
mse_411_luma = immse(lena_ycbcr(:, :, 1), Y_subsampled);

% 
disp(['MSE 4:2:2: ', num2str(mse_422)]);
disp(['MSE 4:1:1: ', num2str(mse_411)]);
disp(['MSE 4:2:0: ', num2str(mse_420)]);
disp(['MSE 4:1:1 Luma: ', num2str(mse_411_luma)]);
