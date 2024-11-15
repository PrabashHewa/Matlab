
image = imread('miranda1.tif');
[height, width, numChannels] = size(image);

centerSize = 100;
centerStartX = floor((width - centerSize) / 2) + 1;
centerStartY = floor((height - centerSize) / 2) + 1;
centerEndX = centerStartX + centerSize - 1;
centerEndY = centerStartY + centerSize - 1;


noiseLevel = 30;
noise = noiseLevel * randn(centerSize, centerSize);
noisyImage = image;
noisyImage(centerStartY:centerEndY, centerStartX:centerEndX, :) = ...
    image(centerStartY:centerEndY, centerStartX:centerEndX, :) + uint8(noise);


figure;
subplot(1, 2, 1);
imshow(image);
title('Original Image');

subplot(1, 2, 2);
imshow(noisyImage);
title('Noisy Image');

alphaValues = [10,70,100];


for k = 1:length(alphaValues)
    alpha = alphaValues(k);
    filteredImage = med_filter_thresholded(noisyImage, 3, alpha);
    
    figure;
    imshow(uint8(filteredImage));
    title(['Filtered Image (Alpha = ', num2str(alpha), ')']);
end



% When we want to keep edges or details in a picture while lowering noise,
% we might want to use a defined median filter instead. We can change how
% much filtering is done with the cutoff because of the difference between
% the original pixel brightness and the The middle number. Sometimes this
% is helpful when a narrow median. The filter might make some parts of the
% picture look too smooth.
