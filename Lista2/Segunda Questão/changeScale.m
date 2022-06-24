function nimg = changeScale(img, scale)
[lin, col, ~] = size(img);
nimg = zeros(lin, col);
matT1 = [1 0 -lin/2; 0 1 -col/2; 0 0 1];
matE = [scale 0 0; 0 scale 0; ...
       0 0 1];
matT2 = [1 0 lin/2; 0 1 col/2; 0 0 1];
maT = matT2 * matE * matT1;
for i = 1 : lin
    for j = 1 : col
        ncoord = maT * [i; j; 1];
        ni = floor(ncoord(1));
        nj = floor(ncoord(2));
        if ni > 0 && ni <= lin && nj > 0 && nj <= col
            nimg(ni, nj) = img(i,j);
        end
    end
end
nimg = uint8(nimg);