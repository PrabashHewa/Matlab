
originalImage = imread('mbaboon.bmp');


blockSize = [4, 4];
replaceFunc = @(blockStruct) blockStruct.data(2, 2);
downSampledImage_a = blockproc(originalImage, blockSize, replaceFunc);

figure(1)
imshow(downSampledImage_a);
%%
%Part b
replaceFunc = @(blockStruct) blockStruct.data(1, 1);
downSampledImage_b = blockproc(originalImage, blockSize, replaceFunc);

figure(2)
imshow(uint8(downSampledImage_b));
%%
%Part c
replaceFunc = @(blockStruct) mean(blockStruct.data(:));
downSampledImage_c = blockproc(originalImage, blockSize, replaceFunc);

figure(3)
imshow(uint8(downSampledImage_c));

