image = imread('cameraman.tif');

image_double = im2double(image);
% image_un = im2uint8(image);
cutoff = 20;
n = 2;

lf = BWLPfilter(image, cutoff, n);
Xf = fftshift(fft2(image_double));
Sf= lf.*Xf;
xt= ifft2(ifftshift(Sf));
%low_pass_result = image_double .* lf;
high_pass_result = (1 - lf).* Xf ;
Ht = ifft2(ifftshift(high_pass_result));

figure(1);
imshow(image);
title('Original Image');
figure(2);
subplot(2, 2, 1);
%imshow(lf);
imagesc(lf);
title('Butterworth Low-pass Filter');
subplot(2, 2, 2);
imshow(real(xt));
title('Low-pass Filtered Image');
subplot(2, 2, 3);
imshow(1 - lf);
title('Butterworth High-pass Filter');
subplot(2, 2, 4);
imshow(real(Ht));
title('High-pass Filtered Image');



