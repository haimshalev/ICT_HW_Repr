function [ BadPixelMatrix ] = BadPixelsRecognition2(OriginalImage_RGB, Threshold)
        
    ProtanopesImage_RGB = protanopes(OriginalImage_RGB);
    
    
    XYZtoRGB = [ 3.2405 -1.5372 -0.4985;
                -0.9693  1.8760  0.0416;
                0.0556 -0.2040  1.0573];
    
    sizeImage = size(OriginalImage_RGB);
    OriginalImage_2D = reshape(OriginalImage_RGB, [sizeImage(1)*sizeImage(2) sizeImage(3)])';  
    OriginalImage_XYZ_2D = XYZtoRGB\double(OriginalImage_2D);
    OriginalImage_XYZ = reshape(OriginalImage_XYZ_2D',[sizeImage(1) sizeImage(2) sizeImage(3)]);
    cform = makecform('xyz2lab');
    OriginalImage_LAB = applycform(OriginalImage_XYZ, cform); 
    
    sizeImage = size(ProtanopesImage_RGB);
    ProtanopesImage_2D = reshape(ProtanopesImage_RGB, [sizeImage(1)*sizeImage(2) sizeImage(3)])';  
    ProtanopesImage_XYZ_2D = XYZtoRGB\double(ProtanopesImage_2D);
    ProtanopesImage_XYZ = reshape(ProtanopesImage_XYZ_2D',[sizeImage(1) sizeImage(2) sizeImage(3)]);
    cform = makecform('xyz2lab');
    ProtanopesImage_LAB = applycform(ProtanopesImage_XYZ, cform);
    
    OriginalImage_L = OriginalImage_LAB(:,:,1);
    OriginalImage_A = OriginalImage_LAB(:,:,2);
    OriginalImage_B = OriginalImage_LAB(:,:,3);

    ProtanopesImage_L = ProtanopesImage_LAB(:,:,1);
    ProtanopesImage_A = ProtanopesImage_LAB(:,:,2);
    ProtanopesImage_B = ProtanopesImage_LAB(:,:,3);

    [SizeX,SizeY,~] = size(OriginalImage_LAB);

    BadPixelMatrix_double = zeros(SizeX,SizeY);

    for i=1:SizeX
        for j=1:SizeY
            BadPixelMatrix_double(i,j) = BadPixelMatrix_double(i,j) + abs(OriginalImage_A(i,j) -  ProtanopesImage_A(i,j));
            BadPixelMatrix_double(i,j) = BadPixelMatrix_double(i,j) + abs(OriginalImage_B(i,j) -  ProtanopesImage_B(i,j));
        end
    end

    BadPixelMatrix = false(SizeX,SizeY);
    
    for i=1:SizeX
        for j=1:SizeY
            if BadPixelMatrix_double(i,j) > Threshold
                BadPixelMatrix(i,j) = true;
            end
        end
    end
end