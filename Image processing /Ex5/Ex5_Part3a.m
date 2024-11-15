
image = imread('miranda1.tif');

[height, width, numChannels] = size(image);

centerSize = 100;

centerStartX = floor((width - centerSize) / 2) + 1;
centerStartY = floor((height - centerSize) / 2) + 1;
centerEndX = centerStartX + centerSize - 1;
centerEndY = centerStartY + centerSize - 1;


 noiseLevel = 40; 
 noise = noiseLevel * randn(centerSize, centerSize);
 image(centerStartY:centerEndY, centerStartX:centerEndX) = ...
 image(centerStartY:centerEndY, centerStartX:centerEndX) + uint8(noise);

figure;
subplot(1, 2, 1);
imshow(imread('miranda1.tif'));
title('Original Image');

subplot(1, 2, 2);
imshow(image);
title('Image with White Noise');
imwrite(image, 'miranda1_with_noise.tif');



