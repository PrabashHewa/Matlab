

function filtered_images = directional_filtering(input_image, filter_size)
    filters = zeros(filter_size, filter_size, 4);
    filters(:, :, 1) = fspecial('average', [filter_size, filter_size]);
    filters(:, :, 2) = imrotate(filters(:, :, 1), 45, 'crop');
    filters(:, :, 3) = imrotate(filters(:, :, 1), 90, 'crop');
    filters(:, :, 4) = imrotate(filters(:, :, 1), 135, 'crop');
    filtered_images = zeros(size(input_image, 1), size(input_image, 2), 4);
    for i = 1:4
        filtered_images(:, :, i) = imfilter(input_image, filters(:, :, i), 'conv', 'same', 'replicate');
    end
end
