function histequal(input_image_path, output_image_path)
   
    input_image = imread(input_image_path);
    
    % Calculate the histogram 
    num_pixels = numel(input_image);
    histogram = zeros(256, 1);
    for i = 1:num_pixels
        pixel_value = input_image(i);
        histogram(pixel_value + 1) = histogram(pixel_value + 1) + 1;
    end
    
    % CDF
    cdf = cumsum(histogram) / num_pixels;
    
    % histogram equalization
    output_image = uint8(255 * cdf(input_image + 1));
    imwrite(output_image, output_image_path);
    
  
    % % Display original and equalized histograms
    % subplot(2, 2, 1);
    % imhist(input_image);
    % title('Original Histogram');
    % 
    % subplot(2, 2, 2);
    % imhist(output_image);
    % title('Equalized Histogram');
    
    % Display original and equalized images
    subplot(1, 2, 1);
    imshow(input_image);
    title('Original Image');
    
    subplot(1, 2, 2);
    imshow(output_image);
    title('Equalized Image');
    
end


