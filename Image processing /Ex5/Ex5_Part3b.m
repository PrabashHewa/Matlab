
image = imread('miranda1_with_noise.tif');

filterSizes = [3, 5, 7];
figure;

for i = 1:length(filterSizes)
    filterSize = filterSizes(i);
    filteredImage = med_filter(image, filterSize);
    subplot(1, length(filterSizes), i);
    imshow(uint8(filteredImage));
    title(['Filter Size = ' num2str(filterSize)]);
end





