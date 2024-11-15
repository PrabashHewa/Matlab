
img = imread('university.png');

% Normalize the image to [0, 1]
img = double(img) / 255;

% (a) Log Transformation
c = 7;  
log_transformed_img = c * log(1 + img);

% (b) Power-law Transformation
c = 6;  
gamma = 0.75;  
power_law_transformed_img = c * (img.^gamma);


figure(1)
imshow(img), title('Original Image');
figure(2)
imshow(log_transformed_img), title('Log Transformation');
figure(3)
imshow(power_law_transformed_img), title('Power-law Transformation');

