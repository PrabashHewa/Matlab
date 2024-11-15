
man_image = imread('man8.png');
woman_image = imread('wom1.png');


stretched_man_image = ContrastStretch(man_image);
stretched_woman_image = ContrastStretch(woman_image);

figure;
subplot(2, 2, 1);
imshow(man_image);
title('Original man8');
subplot(2, 2, 2);
histogram(man_image);
%bar(ContrastStretch(man_image));
title('Histogram of Original man8');

subplot(2, 2, 3);
imshow(stretched_man_image);
title('Contrast Stretched man8');
subplot(2, 2, 4);
histogram(stretched_man_image);
%bar(ContrastStretch(stretched_man_image));
title('Histogram of Stretched man8');

figure;
subplot(2, 2, 1);
imshow(woman_image);
title('Original wom1');
subplot(2, 2, 2);
histogram(woman_image);
%bar(1:256, ContrastStretch(woman_image));
title('Histogram of Original wom1');

subplot(2, 2, 3);
imshow(stretched_woman_image,[]);
title('Contrast Stretched wom1');
subplot(2, 2, 4);
histogram(stretched_woman_image);
%bar(1:256, ContrastStretch(stretched_woman_image));
title('Histogram of Stretched wom1');
