%%
% c) Upsample components back to original resolution and convert to RGB
% Upsample chrominance components
% Upsample chrominance components
lena_ycbcr_upsampled_422 = lena_ycbcr_422;
lena_ycbcr_upsampled_411 = lena_ycbcr_411;
lena_ycbcr_upsampled_420 = lena_ycbcr_420;

lena_ycbcr_upsampled_422(:, 1:subsampling_ratio_422(2):end, 2:3) = 128; 

lena_ycbcr_upsampled_411(:, 1:subsampling_ratio_411(2):end, 2:3) = 128; 

lena_ycbcr_upsampled_420(1:subsampling_ratio_420(1):end, :, 2:3) = 128; 

% Upsample luminance component
lena_y_upsampled_411 = imresize(lena_y_411, [size(lena_ycbcr, 1), size(lena_ycbcr, 2)], 'nearest');

% Recombine
lena_upsampled_422 = cat(3, lena_y_upsampled_411, lena_ycbcr_upsampled_422(:, 1:subsampling_ratio_422(2):end));
lena_upsampled_411 = cat(3, lena_y_upsampled_411, lena_ycbcr_upsampled_411(:, 1:subsampling_ratio_411(2):end));
lena_upsampled_420 = cat(3, lena_y_upsampled_411, lena_ycbcr_upsampled_420(1:subsampling_ratio_420(1):end));

% Convert to RGB
lena_rgb_upsampled_422 = ycbcr2rgb(lena_upsampled_422);
lena_rgb_upsampled_411 = ycbcr2rgb(lena_upsampled_411);
lena_rgb_upsampled_420 = ycbcr2rgb(lena_upsampled_420);

figure;
subplot(2, 3, 1);
imshow(lena_rgb);
title('Original');

subplot(2, 3, 2);
imshow(lena_rgb_upsampled_422);
title('4:2:2 Upsampled');

subplot(2, 3, 3);
imshow(lena_rgb_upsampled_411);
title('4:1:1 Upsampled');

subplot(2, 3, 4);
imshow(lena_rgb_upsampled_420);
title('4:2:0 Upsampled');

subplot(2, 3, [5, 6]);
imshow(imabsdiff(lena_rgb, lena_rgb_upsampled_422) + imabsdiff(lena_rgb, lena_rgb_upsampled_411) + imabsdiff(lena_rgb, lena_rgb_upsampled_420), []);
title('Perceptual Difference');
%%

% d) Calculate mean squared error values

mse_422 = immse(lena_rgb, lena_rgb_upsampled_422);
mse_411 = immse(lena_rgb, lena_rgb_upsampled_411);
mse_420 = immse(lena_rgb, lena_rgb_upsampled_420);

fprintf('MSE for 4:2:2 subsampling: %.4f\n', mse_422);
fprintf('MSE for 4:1:1 subsampling: %.4f\n', mse_411);
fprintf('MSE for 4:2:0 subsampling: %.4f\n', mse_420);
