%Fabio Henrique Alves Fernandes 19.1.4128

function lista2 (image_lenna)

    lenna = imgread(image_lenna);

    %Questão 1
    %a)
    function using_imadjust (img)
        histLenna = imhist(img);
        figure(1);
        plot(histLenna);

        nimg = imadjust(img, [100/255 160/255], [0.1 0.9]);
        figure(2);
        imshow(nimg);
    end

    %b)
    function fixing_contrast (img)
        image_double = im2double(img);
        LowHigh = stretchlim(image_double);
        imst = 1 ./ (1 + (0.6 ./ image_double) .^ 3);
        nimg = imadjust (img, [LowHigh], [0.1 0.9]);
        figure(1);
        imshow(nimg);
        figure(2);
        imshow(imst);
    end

    %c)
    function power_low_transformation (img)
        imd = im2double(img);
        imgama = 0.7*(imd ^ 1);
        figure(2);
        imshow(imgama)
    end


    %Questão 2
    function my_edge_enhancement (img, k)
        [lin, col, ~] = size(img);
        nimg = zeros(lin, col);
        
        nimg(k:lin, k:col) = img(1:lin-k+1, 1:col-k+1);
        
        nimg = img - nimg;

        imshow(nimg);
    end

    using_imadjust (lenna);
    fixing_contrast (lenna);
    power_low_transformation (lenna);
    my_edge_enhancement (lenna, 10);

end