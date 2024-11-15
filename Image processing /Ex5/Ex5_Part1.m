
% img = imread('cameraman.tif');
% A = [8, 9, 9.7];
% laplacian_kernel = [0, -1, 0; -1, 9, -1; 0, -1, 0] + A(1) * eye(3);
% 
% result1 = imfilter(double(img), laplacian_kernel, 'conv', 'same', 'replicate');
% scaled_laplacian_kernel2 = A(2) * laplacian_kernel;
% result2 = imfilter(double(img), scaled_laplacian_kernel2, 'conv', 'same', 'replicate');
% 
% scaled_laplacian_kernel3 = A(3) * laplacian_kernel;
% result3 = imfilter(double(img), scaled_laplacian_kernel3, 'conv', 'same', 'replicate');
% 
% subplot(2, 2, 1), imshow(img), title('Original Image');
% subplot(2, 2, 2), imshow(result1, []), title('Laplacian Enhancement A=8');
% subplot(2, 2, 3), imshow(result2, []), title('Laplacian Enhancement A=9');
% subplot(2, 2, 4), imshow(result3, []), title('Laplacian Enhancement A=9.7');

%A =[8,9,9.7]
%result2 = imfilter(img, laplacian_kernel_with_A, 'conv');
%result_with_A = imfilter(double(img), laplacian_kernel_with_A, 'conv', 'same', 'replicate');
%aplacian_kernel_with_A = [A(1), -1, A(2); -1, A(3), -1; A(2), -1, A(1)];

img = imread('cameraman.tif');

laplacian_kernel1 = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
laplacian_kernel2 = [-1, -1, -1; -1, 9, -1; -1, -1, -1];
laplacian_kernel3 = [-1, -1, -1; -1, 9.7, -1; -1, -1, -1];

result1 = imfilter((img), laplacian_kernel1, 'conv');
result2 = imfilter((img), laplacian_kernel2, 'conv' );
result3 = imfilter((img), laplacian_kernel3, 'conv');

figure;

subplot(2, 2, 1), imshow(uint8(img)), title('Original Image');
subplot(2, 2, 2), imshow(uint8(result1)), title('Laplacian Enhancement A=8');
subplot(2, 2, 3), imshow(uint8(result2)), title('Laplacian Enhancement A=9');
subplot(2, 2, 4), imshow(uint8(result3)), title('Laplacian Enhancement A=9.7');


