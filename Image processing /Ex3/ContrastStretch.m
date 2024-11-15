function stretched_image = ContrastStretch(input_image)
    % Find the minimum and maximum values in the input image
    min_value = min(input_image(:));
    max_value = max(input_image(:));
    
    % Calculate the slope and intercept for contrast stretching
    slope = 255 / (max_value - min_value);
    intercept = -slope * min_value;

    % Apply contrast stretching to the input image
    stretched_image = slope * input_image + intercept;
    
    % Clip the values to the range [0, 255]
    stretched_image(stretched_image < 0) = 0;
    stretched_image(stretched_image > 255) = 255;
    
    % Convert to uint8 data type
    stretched_image = uint8(stretched_image);
end
