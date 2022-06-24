%Fabio Henrique Alves Fernandes 19.1.4128

function lista6 (img_path) 
    img = imread (img_path)
    
    %Questao 1
    function test (img)
        nimg = im2double (img)
        [row, col, ~] = size (img)
        z = zeros (row, col)
        for i = 1 : row
            for j = 1 : col
                z (i, j) = nimg (i, j)
            end
        end
    end


    %Questao2
    function T = threshold_global(img)
        nimg = im2double(img)
        [row, col, ~] = size(img)
        T = 0
        for i = 1: row
          for j =1: col
            T = T + img(i,j)
          end
        end
        T = T/(row * col)
        
        contG1 = 0
        contG2 = 0
        G1 = 0
        G2 = 0
        Nt = 0
        Kt = T
        do
          T = Kt
            for i = 1: row
              for j =1: col
                if T > nimg(i,j)
                  contG1 = contG1 + 1
                  G1 = G1 + nimg(i,j)
                else
                  contG2 = contG2 + 1
                  G2 = G2 + nimg(i,j)
                end
              end
            end
          u1 = G1/contG1
          u2 = G2/contG2
          Nt = (u1 + u2) / 2
          Kt = Nt
        until ((Nt - T) < 0.0010)
      
        imshow(nimg > T)
        end

        %Questao 3

        
        %Questao 4
        function otsu_method(img)  
            nimg = im2double(img);  
            [row, col, ~] = size(img);  
            z = zeros(row, col);  
            for i = 1 : row    
                for j = 1 : col  
                    z(i,j) = nimg(i,j)   
                end  
            end
            T = graythresh(nimg);
            imshow(nimg > T);
        end

    test (img)
    threshold_global (img)
    otsu_method (img)
end

    
