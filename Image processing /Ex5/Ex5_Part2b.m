
original_img = imread('cameraman.tif');
max_intensity = 10;
noise = randn(size(original_img)) * max_intensity;
noisy_img = original_img + uint8(noise);

filter_sizes = [3, 5, 7];

for i = 1:length(filter_sizes)
    filtered_images = directional_filtering(noisy_img, filter_sizes(i));

    figure;
    for j = 1:4
        subplot(2, 2, j), imshow(filtered_images(:, :, j), []),...
        title(['Direction ' num2str((j-1)*45) ' - Kernel ' num2str(filter_sizes(i)) 'x' ...
        num2str(filter_sizes(i))]);
    end
    sgtitle(['Filtered Images - Kernel Size ' num2str(filter_sizes(i)) 'x' num2str(filter_sizes(i))]);
end
