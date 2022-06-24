function L = RGB(img, times)
  img = double(img);

  R = img(:,:,1);
  G = img(:,:,2);
  B = img(:,:,3);
for i = 1 : times
  R = R * 0.299;
  G = G * 0.587;
  B = B * 0.114;
end
L = cat(3, R, G, B);

imshow(uint8(L));