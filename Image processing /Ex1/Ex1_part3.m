clear all;
close all;

S    = [0 0 0 0 0 0 0 1 1 0;
        0 0 0 1 0 0 1 0 0 1;
        0 0 0 1 0 1 1 0 0 0;
        0 0 1 1 1 0 0 0 0 0;
        0 0 1 1 1 0 0 1 1 1];

figure;
imshow(S, 'InitialMagnification', 'fit'); 
colormap(gray(2)); 
axis on;

S1 = S(1:4,2:5);
S2= S(1:4,6:9);

count_S1 = sum(S1(:) ~= 0);
count_S2 = sum(S2(:) ~= 0);

fprintf('Non-zero values in S1 is: %d\n', count_S1);
fprintf('Non-zero values in S2 is: %d\n', count_S2);

load('S.mat'); 

if exist('S', 'var') 
    count_S = sum(S(:) ~= 0);
    fprintf('Non-zero values in the loaded matrix S is: %d\n', count_S);

end


