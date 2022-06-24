function functionsTest(img)
imgGray = rgb2gray(img);
figure(1);
imshow(imgGray);
imwrite(imgGray, 'imgGray.png')
[imgInd, map] = rgb2ind(img);
imgDouble = im2double(img);
figure(2);
imshow(imgDouble);
imwrite(imgDouble, 'imgDouble.png')
BW = im2bw(img,0.4);
imshow(BW)