I = imread('lena_face.png');
I = double(I); 

levels = [128, 64, 32, 16, 8, 4];
quantized_images = cell(1, numel(levels));

for k = 1:numel(levels)
    step = 256/levels(k);
    partition = step:step:256-step;
    codebook = step/2:step:256-step/2;
    [~, quantized_image] = quantiz(I(:), partition, codebook);
    quantized_images{k} = uint8(reshape(quantized_image, size(I)));
    figure;
    imshow(quantized_images{k})
end
%%
% Without noise
level = 16;
step = 256/level;
partition = step:step:256-step;
codebook = step/2:step:256-step/2;
[~, quantized_without_noise] = quantiz(I(:), partition, codebook);
quantized_without_noise = uint8(reshape(quantized_without_noise, size(I)));

% Adding noise
noise_std = 5; 
I_noisy = I + noise_std * randn(size(I));
I_noisy = min(max(I_noisy,0),255);

[indx, quantized_with_noise] = quantiz(I_noisy(:), partition, codebook);
quantized_with_noise = uint8(reshape(quantized_with_noise, size(I)));
figure(7)
imshowpair(quantized_without_noise, quantized_with_noise, 'montage');
