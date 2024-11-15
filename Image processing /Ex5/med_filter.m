
function filteredImage = med_filter(image, filterSize)
 
    paddedImage = padarray(image, [floor(filterSize/2), floor(filterSize/2)], 'replicate');
    filteredImage = zeros(size(image));
    for i = 1:size(image, 1)
        for j = 1:size(image, 2)
            neighborhood = paddedImage(i:i+filterSize-1, j:j+filterSize-1);
            filteredImage(i, j) = median(neighborhood(:));
        end
    end
end


 

