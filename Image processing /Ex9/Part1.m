%% Part A
originalImage = imread('fruits.jpg');

% figure;
% imshow(originalImage);
% title('Original Image');

R = originalImage(:,:,1);
G = originalImage(:,:,2);
B = originalImage(:,:,3);

R_eq = histeq(R);
G_eq = histeq(G);
B_eq = histeq(B);

equalizedImage = cat(3, R_eq, G_eq, B_eq);

figure(1);
subplot(2, 2, 1);
imshow(equalizedImage);
title('Equalized Image');

subplot(2, 2, 2);
imshow(R_eq);
title('Equalized R Component');

subplot(2, 2, 3);
imshow(G_eq);
title('Equalized G Component');

subplot(2, 2, 4);
imshow(B_eq);
title('Equalized B Component');

%% Part B

equalizedImage = intensityeq(originalImage);

figure(2);
subplot(1, 2, 1);
imshow(originalImage);
title('Original Image');

subplot(1, 2, 2);
imshow(equalizedImage);
title('Equalized Image');

%% Part C

fruitsImage = imread('fruits.jpg');
festiaImage = imread('festia.jpg');

fruitsEqualizedRGB = equalizeRGB(fruitsImage);
fruitsEqualizedIntensity = intensityeq(fruitsImage);

festiaEqualizedRGB = equalizeRGB(festiaImage);
festiaEqualizedIntensity = intensityeq(festiaImage);


figure(3);

subplot(2, 3, 1);
imshow(fruitsImage);
title('Original fruits.jpg');

subplot(2, 3, 2);
imshow(fruitsEqualizedRGB);
title('Equalized RGB fruits.jpg');

subplot(2, 3, 3);
imshow(fruitsEqualizedIntensity);
title('Equalized Intensity fruits.jpg');

subplot(2, 3, 4);
imshow(festiaImage);
title('Original festia.jpg');

subplot(2, 3, 5);
imshow(festiaEqualizedRGB);
title('Equalized RGB festia.jpg');

subplot(2, 3, 6);
imshow(festiaEqualizedIntensity);
title('Equalized Intensity festia.jpg');
