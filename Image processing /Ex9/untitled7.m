% Load the image
originalImage = imread('lake.jpg');

% Convert the image to grayscale
grayImage = rgb2gray(originalImage);

% Use Otsu's method to find a threshold
threshold = graythresh(grayImage);

% Convert the grayscale image to binary using the threshold
binaryImage = imbinarize(grayImage, threshold);  % Use imbinarize instead of im2bw

% Perform morphological operations to enhance the binary image
se = strel('disk', 20);
binaryImage = imclose(binaryImage, se);

% Label connected components in the binary image
labeledImage = bwlabel(binaryImage);

% Measure the area of each labeled region
regionProperties = regionprops(labeledImage, 'Area');

% Find the index of the region with the largest area
[~, maxIndex] = max([regionProperties.Area]);

% Create a binary mask of the largest lake
largestLakeMask = (labeledImage == maxIndex);

% Apply the mask to the original RGB image
extractedLake = originalImage;  % Copy the original image
for channel = 1:3
    extractedLake(:, :, channel) = extractedLake(:, :, channel) .* uint8(largestLakeMask);
end

% Display the original image and the extracted lake
figure;
subplot(1, 2, 1);
imshow(originalImage);
title('Original Image');

subplot(1, 2, 2);
imshow(extractedLake);
title('Extracted Lake');
