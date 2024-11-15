% a) Load RGB image and convert to YCbCr colorspace
lena_rgb = imread('lena.tiff');
lena_ycbcr = rgb2ycbcr(lena_rgb);

% Display Y, Cb, and Cr in a 1x3 subplot
figure;
subplot(1, 3, 1), imshow(lena_ycbcr(:, :, 1)), title('Y Component');
subplot(1, 3, 2), imshow(lena_ycbcr(:, :, 2)), title('Cb Component');
subplot(1, 3, 3), imshow(lena_ycbcr(:, :, 3)), title('Cr Component');

% b) Subsampling of chrominance and luminance components
% Subsampling formats: 4:2:2, 4:1:1, 4:2:0 for chrominance; 4:1:1 for luminance
subsampling_factors = [2, 1, 2]; % Change as needed

Y_subsampled = lena_ycbcr(:, :, 1);
Cb_subsampled = lena_ycbcr(:, 1:subsampling_factors(1):end, 2);
Cr_subsampled = lena_ycbcr(:, 1:subsampling_factors(1):end, 3);

% c) Upsample components back to original resolution and convert to RGB
Cb_upsampled = imresize(Cb_subsampled, size(Y_subsampled), 'nearest');
Cr_upsampled = imresize(Cr_subsampled, size(Y_subsampled), 'nearest');

% Recombine subsampled components
lena_subsampled_ycbcr = cat(3, Y_subsampled, Cb_upsampled, Cr_upsampled);

% Convert subsampled YCbCr images back to RGB
lena_subsampled_rgb_422 = ycbcr2rgb(lena_subsampled_ycbcr);

% Display original and subsampled RGB images
figure;
subplot(2, 3, 1), imshow(lena_rgb), title('Original');
subplot(2, 3, 2), imshow(lena_subsampled_rgb_422), title('4:2:2 Subsampled');

% Calculate mean squared error values
mse_422 = immse(lena_rgb, lena_subsampled_rgb_422);

% Display MSE value
disp(['MSE 4:2:2: ', num2str(mse_422)]);

