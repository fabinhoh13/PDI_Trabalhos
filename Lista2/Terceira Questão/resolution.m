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
    
imshow(newImg)


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

imshow(newImg2)