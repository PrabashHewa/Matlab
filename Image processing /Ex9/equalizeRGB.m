function equalizedImage = equalizeRGB(inputImage)
    
    R = inputImage(:,:,1);
    G = inputImage(:,:,2);
    B = inputImage(:,:,3);

    R_eq = histeq(R);
    G_eq = histeq(G);
    B_eq = histeq(B);

    equalizedImage = cat(3, R_eq, G_eq, B_eq);
end
