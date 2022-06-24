function lista2

%Questão 1
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
    end

%Questão 2

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
    end

    function nimg = changeDist(img, dist)
        [lin, col, ~] = size(img);
        nimg = zeros(lin, col);
        matT1 = [1 0 -lin/2; 0 1 -col/2; 0 0 1];
        matD = [1 dist 0; 0 1 0; ...
               0 0 1];
        matT2 = [1 0 lin/2; 0 1 col/2; 0 0 1];
        maT = matT2 * matD * matT1;
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
    end

    function nimg = translation(img, transx, transy)
        [lin, col, ~] = size(img);
        nimg = zeros(lin, col);
        matT1 = [1 0 -lin/2; 0 1 -col/2; 0 0 1];
        matTr = [1 0 transx; 0 1 transy; ...
               0 0 1];
        matT2 = [1 0 lin/2; 0 1 col/2; 0 0 1];
        maT = matT2 * matTr * matT1;
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
    end

    function nimg = rotation(img, ang)
        [lin, col, ~] = size(img);
        nimg = zeros(lin, col);
        matT1 = [1 0 -lin/2; 0 1 -col/2; 0 0 1];
        matR = [sind(ang) -cosd(ang) 0; cosd(ang) sind(ang) 0; ...
               0 0 1];
        matT2 = [1 0 lin/2; 0 1 col/2; 0 0 1];
        maT = matT2 * matR * matT1;
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
    end

%Questão 3

    function resolution(img)
        [rows, columns, ~] = size(img);
        newImg = zeros(floor(rows/2), floor(columns/2));
            
        rowCount = 1;
        columnCount = 1;
        for i = 1:2:rows
            columnCount = 1;
            for j = 1:2:columns
                average = floor(mean(mean(img(i:i+1, j:j+1), 1), 2));
                newImg(rowCount, columnCount) = average;
                
                columnCount = columnCount + 1;
            end
            rowCount = rowCount + 1;
        end
            
        imshow(newImg);
        
        
        [rows, columns, ~] = size(newImg);
        
        newImg2 = zeros(rows*2, columns*2);
            
        rowCount = 1;
        columnCount = 1;
        for i = 1:rows
            columnCount = 1;
            for j = 1:columns
                newImg2(rowCount, columnCount) = newImg(i, j);
                newImg2(rowCount, columnCount+1) = newImg(i, j);
                newImg2(rowCount+1, columnCount) = newImg(i, j);
                newImg2(rowCount+1, columnCount+1) = newImg(i, j);
                
                columnCount = columnCount + 2;
            end
            rowCount = rowCount + 2;
        end
        
        imshow(newImg2);
    end

%Questão 4

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
        imshow(BW);
    end

%Questão 5

    function flipImage(img)
        [lin, col, ~] = size(img);
        
        nimg = img(1:lin, col:-1:1);
        figure(1)
        imshow(nimg);
        
        nimg = nimg(lin:-1:1, 1:col);
        figure(2)
        imshow(nimg);
    end

end
