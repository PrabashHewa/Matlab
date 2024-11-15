
lena = imread('lena.jpg');
salt_pepper_noise = imnoise(lena, 'salt & pepper', 0.05);
salt_pepper_noise = double(salt_pepper_noise);

% WMF
window_size = 5;
weight_kernel = ones(window_size);
weight_kernel(round(window_size/2), round(window_size/2)) = 5; 
wmf_filtered_image = weightedMedianFilter(salt_pepper_noise, window_size, weight_kernel);


figure;

subplot(2, 2, 1);
imshow(lena);
title('Original Image');

subplot(2, 2, 2);
imshow(uint8(salt_pepper_noise));  
title('Salt & Pepper Noise');

median_filtered_image = medfilt2(uint8(salt_pepper_noise), [window_size, window_size]);
subplot(2, 2, 3);
imshow(median_filtered_image);
title('Original Median Filter');

subplot(2, 2, 4);
imshow(uint8(wmf_filtered_image)); 
title('Weighted Median Filter');

function output = weightedMedianFilter(input, window_size, weight_kernel)
    [rows, cols] = size(input);
    pad_size = floor(window_size/2);
    input_padded = padarray(input, [pad_size, pad_size], 'replicate', 'both');
    output = zeros(size(input));

    for i = 1:rows
        for j = 1:cols
            window = input_padded(i:i+window_size-1, j:j+window_size-1);
            weights = weight_kernel .* window;
            sorted_values = sort(weights(:));
            median_index = ceil(sum(weight_kernel(:))/2);
            output(i, j) = sorted_values(median_index);
        end
    end
end
