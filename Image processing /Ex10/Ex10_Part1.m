
cheetahImage = imread('cheetah.jpg');
chameleonImage = imread('chameleon.jpg');

distCube = 50; 
resultCheetahCube = sliceCube(cheetahImage, distCube);
resultChameleonCube = sliceCube(chameleonImage, distCube);

distSphere = 150; 
resultCheetahSphere = sliceSphere(cheetahImage, distSphere);
resultChameleonSphere = sliceSphere(chameleonImage, distSphere);

figure;
subplot(2, 2, 1); imshow(resultCheetahCube); title('Cheetah - sliceCube');
subplot(2, 2, 2); imshow(resultChameleonCube); title('Chameleon - sliceCube');
subplot(2, 2, 3); imshow(resultCheetahSphere); title('Cheetah - sliceSphere');
subplot(2, 2, 4); imshow(resultChameleonSphere); title('Chameleon - sliceSphere');
