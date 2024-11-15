
image1 = 63 * ones(400, 400, 'uint8');
image2 = 223 * ones(400, 400, 'uint8');

center_x = 120:280; % 160 pixels wide
center_y = 120:280; % 160 pixels high

image1(center_x, center_y) = 127;
image2(center_x, center_y) = 185;

figure(1)
subplot(1, 2, 1);
imshow(image1);
subplot(1, 2, 2);
imshow(image2);

% average of the two background values (63+223)/2= 146
square1 = 223 * ones(400, 400, 'uint8');
square1(center_x, center_y) = 223;




