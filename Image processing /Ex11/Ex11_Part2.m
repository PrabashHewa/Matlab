Image = imread("lena.tiff");
len = size(Image);
Image_ycbcr = rgb2ycbcr(Image);

%% a

figure
subplot(1, 3, 1), imshow(Image_ycbcr(:, :, 1)), title('Y Component');
subplot(1, 3, 2), imshow(Image_ycbcr(:, :, 2)), title('Cb Component');
subplot(1, 3, 3), imshow(Image_ycbcr(:, :, 3)), title('Cr Component');

%% b and c
Image_cb422 = Image_ycbcr(:, 1:2:end, 2);
Image_cr422 = Image_ycbcr(:, 1:2:end, 3);
Image_cb422 = imresize(Image_cb422, [len(1), len(2)]);
Image_cr422 = imresize(Image_cr422, [len(1), len(2)]);
Image_ycbcr_422 = Image_ycbcr;
Image_ycbcr_422(:, :, 2) = Image_cb422;
Image_ycbcr_422(:, :, 3) = Image_cr422;
subsampled_rgb_422 = ycbcr2rgb(Image_ycbcr_422);

Image_cb411 = Image_ycbcr(:, 1:4:end, 2);
Image_cr411 = Image_ycbcr(:, 1:4:end, 3);
Image_cb411 = imresize(Image_cb411, [len(1), len(2)]);
Image_cr411 = imresize(Image_cr411, [len(1), len(2)]);
Image_ycbcr_411 = Image_ycbcr;
Image_ycbcr_411(:, :, 2) = Image_cb411;
Image_ycbcr_411(:, :, 3) = Image_cr411;
subsampled_rgb_411 = ycbcr2rgb(Image_ycbcr_411);

Image_cb400 = Image_ycbcr(1:2:end, 1:2:end, 2);
Image_cr400 = Image_ycbcr(1:2:end, 1:2:end, 3);
Image_cb400 = imresize(Image_cb400, [len(1), len(2)]);
Image_cr400 = imresize(Image_cr400, [len(1), len(2)]);
Image1_ycbcr_400 = Image_ycbcr;
Image1_ycbcr_400(:, :, 2) = Image_cb400;
Image1_ycbcr_400(:, :, 3) = Image_cr400;
subsampled_rgb_400 = ycbcr2rgb(Image1_ycbcr_400);

Image_y411 = Image_ycbcr(:, 1:4:end, 1);
Image_y411 = imresize(Image_y411, [len(1), len(2)]);
Image_ycbcr_411(:, :, 1) = Image_y411;
subsampled_rgb_y411 = ycbcr2rgb(Image_ycbcr_411);

figure
subplot(2,3,1), imshow(Image), title('Original');
subplot(2,3,2), imshow(subsampled_rgb_422), title('4:2:2');
subplot(2,3,3), imshow(subsampled_rgb_411), title('4:1:1');
subplot(2,3,4), imshow(subsampled_rgb_400), title('4:0:0');
subplot(2,3,5), imshow(subsampled_rgb_y411), title('y 4:1:1');

%% d
mse_422 = immse(subsampled_rgb_422, Image);
mse_411 = immse(subsampled_rgb_411, Image);
mse_400 = immse(subsampled_rgb_400, Image);
mse_y411 = immse(subsampled_rgb_y411, Image);

disp(['MSE 4:2:2 = ', num2str(mse_422)]);
disp(['MSE 4:1:1 = ', num2str(mse_411)]);
disp(['MSE 4:0:0 = ', num2str(mse_400)]);
disp(['MSE y 4:1:1 = ', num2str(mse_y411)]);
