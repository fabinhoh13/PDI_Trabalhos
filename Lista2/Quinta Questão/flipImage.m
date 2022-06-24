function flipImage(img)
[lin, col, ~] = size(img);

nimg = img(1:lin, col:-1:1);
figure(1)
imshow(nimg);

nimg = nimg(lin:-1:1, 1:col);
figure(2)
imshow(nimg);
