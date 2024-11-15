function outputImage = histmatch(inputImage, referenceImage)
    
    inputHist = imhist(inputImage);
    referenceHist = imhist(referenceImage);

    inputCDF = cumsum(inputHist) / sum(inputHist);
    referenceCDF = cumsum(referenceHist) / sum(referenceHist);
    [~, map] = min(abs(inputCDF - referenceCDF'), [], 2);

    outputImage = reshape(map(inputImage(:) + 1), size(inputImage));
    outputImage = uint8(outputImage);
end


