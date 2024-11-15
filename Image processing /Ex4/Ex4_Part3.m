
%inputImageA = imread(spine.jpg);
inputImageA = imread('church.png');
referenceImageB = imread('corel.png');

% Perform histogram matching
outputImage = histmatch(inputImageA, referenceImageB);

imshowpair(inputImageA, outputImage, 'montage');
title('Input Image A vs. Matched Output Image');


% Part 4
% Part a : The value of the histogram equalization does not change when it is
% multiplied by itself.
% Part b : The main idea behind histogram equalisation is to change the
% values of each pixel's strength so that the image's CDF is a straight
% line. This linearization helps spread out the numbers of intensity, which
% makes the contrast better.
% Results can be improve noise reduction or smoothing, to enhance the
% quality of the image and reduce the impact of noise on the equalization
% process.
