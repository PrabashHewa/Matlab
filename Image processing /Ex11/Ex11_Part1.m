
load('yuvdata.mat');

disp(['Size of yy: ', num2str(size(yy))]);
disp(['Size of uu: ', num2str(size(uu))]);
disp(['Size of vv: ', num2str(size(vv))]);

rows = 360; 
cols = 640; 

yy_resized = imresize(reshape(yy, [cols, rows]), [cols, rows]);
uu_resized = imresize(reshape(uu, [cols/2, rows/2]),  [cols, rows]);
vv_resized = imresize(reshape(vv, [cols/2, rows/2]),  [cols, rows]);

figure;
subplot(1,3,1), imshow(uint8(yy_resized')), title('Y Component');
subplot(1,3,2), imshow(uint8(uu_resized')), title('U Component');
subplot(1,3,3), imshow(uint8(vv_resized')), title('V Component');

uu_centered = uu_resized - 127;
vv_centered = vv_resized - 127;

YUV = cat(2, yy_resized(:), uu_centered(:), vv_centered(:));

YuvToRgb = [1 0 1.402 ; 1 -0.34413 -0.71414; 1 1.772 0];
RGB = YuvToRgb * YUV'; 

% rows = size(RGB, 1);
% cols = size(RGB, 2);

R_channel = reshape(RGB(1,:),[cols, rows]);
G_channel = reshape(RGB(2,:), [cols, rows]);
B_channel = reshape(RGB(3,:), [cols, rows]);

RGB_reshaped = cat(3, R_channel', G_channel', B_channel');

%RGB_reshaped = reshape(RGB, [rows, cols, 3]);

figure;
imshow(uint8(RGB_reshaped));
title('RGB Image');
