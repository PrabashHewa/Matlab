

function filteredImage = med_filter_thresholded(image, filterSize, alpha)
    paddedImage = padarray(image, [filterSize, filterSize], 'replicate', 'both');
    filteredImage = zeros(size(image));
    for i = 1:size(image, 1)
        for j = 1:size(image, 2)
            neighbor = paddedImage(i:i+2*filterSize, j:j+2*filterSize);
            medianValue = median(neighbor(:));
            if abs(image(i, j) - medianValue) > alpha
                filteredImage(i, j) = image(i, j);
            else
                filteredImage(i, j) = medianValue;
            end
        end
    end
end

