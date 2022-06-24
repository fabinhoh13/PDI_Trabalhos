%Fábio Henrique Alves Fernandes - 19.1.4128

function lista4 (imgDir, maskDir)
  img = imread (imgDir)
  mask = imread (maskDir)

  %Questão 1
  function [nimg, figs] = noiseSum (img, a)
    [lin, col] size (img)
    nimg = zeros (lin, col)
    figs = zeros (lin, col, n)

    for i = 1 : n
       figs (:, :, floor(n/2))

    endfor

    nfigs = sort (figs, 3)
    nimg = nfigs (:, :, (floor *n/2))
    nimg = uint8 (nimg)
  endfunction

  %Questão 2
  function nimg = blueBackground (img, mask, inc)
    nimg = cat (3, img, img, img)
    nimg = im2double (nimg)
    mask = im2double (mask)
    [lin, col] = size (mask)
    for i = 1 : lin
      for j = 1 : col
        nimg (:, :, 1) = nimg (:, :, 1) + inc
        nimg (:, :, 2) = nimg (:, :, 2) + inc
        nimg (:, :, 3) = nimg (:, :, 3) + 2 * inc
      endfor
    endfor

    nimg = uint8(nimg)
  endfunction

  %Funcionamento

  [nimg, figs] = noiseSum (img, 10)
  imshow (nimg)

  nimg = blueBackground (img, mask, 100)
  imshow (nimg)


 end


