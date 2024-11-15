figure(1)
histequal('moon.png', 'moon_equalized.png');
% histequal('house.png', 'house_equalized.png');
% histequal('spine.jpg', 'spine_equalized.jpg');
% histequal('church.png', 'church_equalized.png');

figure(2)
im=imread('moon.png');
ContrastStretch(im,0,255)


