function equalizedImage = intensityeq(inputImage)
   
    hsvImage = rgb2hsv(inputImage);

    H = hsvImage(:,:,1);
    S = hsvImage(:,:,2);
    V = hsvImage(:,:,3);

    V_eq = histeq(V);

    equalizedHsvImage = cat(3, H, S, V_eq);
    equalizedImage = hsv2rgb(equalizedHsvImage);
end
