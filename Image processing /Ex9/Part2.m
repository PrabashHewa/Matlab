
originalImage = imread('lake.jpg');

grayImage = rgb2hsv(originalImage);
%grayImage=grayImage(:,:,1);
threshold = graythresh(grayImage);
binaryImage = im2bw(grayImage, threshold);

% se = strel('disk', 20);
% binaryImage = imclose(binaryImage, se);

labeledImage = bwlabel(binaryImage);
regionProperties = regionprops(labeledImage, 'Area');
[~, maxIndex] = max([regionProperties.Area]);


largestLakeMask = ismember(labeledImage, maxIndex);

% largestLakeMask = (labeledImage == maxIndex);
%extractedLake = bsxfun(@times, originalImage, cast(largestLakeMask, 'like', originalImage));

extractedLake = bsxfun(@times, originalImage, cast(largestLakeMask, class(originalImage)));

figure;
subplot(1, 2, 1);
imshow(originalImage);
title('Original Image');

subplot(1, 2, 2);
imshow(extractedLake);
title('Extracted Lake ');
