
image = imread('wom1.png');

histogram = zeros(1, 256);

for i = 1:size(image, 1)
    for j = 1:size(image, 2)
        pixel_value = image(i, j);
        histogram(pixel_value + 1) = histogram(pixel_value + 1) + 1;
    end
end

figure;
bar(1:256, histogram);
title('Histogram of wom1.png');
xlabel('Pixel Value');
ylabel('Frequency');
