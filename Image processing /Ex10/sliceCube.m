function result = sliceCube(I, dist)
    
    imshow(I);
    chosenPixels = impixel;
    C = chosenPixels(1, :);
    C = reshape(C, 1, 1, 3);
    C = repmat(C, [size(I, 1), size(I, 2), 1]);
    mask = (sum(abs(double(I) - double(C)), 3) <= dist);
    mask = uint8(mask);
    result = uint8(zeros(size(I)));
    grayColor = [127, 127, 127];
    
    for channel = 1:3
        result(:, :, channel) = mask .* I(:, :, channel) + (1 - mask) * grayColor(channel);
    end
end

