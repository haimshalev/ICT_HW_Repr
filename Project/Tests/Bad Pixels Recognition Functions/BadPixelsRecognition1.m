function [ BadPixelMatrix ] = BadPixelsRecognition1(OriginalImage_RGB, Threshold)
        
    ProtanopesImage_RGB = protanopes(OriginalImage_RGB);

    OriginalImage_R = OriginalImage_RGB(:,:,1);
    OriginalImage_B = OriginalImage_RGB(:,:,2);
    OriginalImage_G = OriginalImage_RGB(:,:,3);

    ProtanopesImage_R = ProtanopesImage_RGB(:,:,1);
    ProtanopesImage_G = ProtanopesImage_RGB(:,:,2);
    ProtanopesImage_B = ProtanopesImage_RGB(:,:,3);

    [SizeX,SizeY,~] = size(OriginalImage_RGB);

    BadPixelMatrix_double = zeros(SizeX,SizeY);

    for i=1:SizeX
        for j=1:SizeY
            BadPixelMatrix_double(i,j) = BadPixelMatrix_double(i,j) + abs(OriginalImage_R(i,j) -  ProtanopesImage_R(i,j));
            BadPixelMatrix_double(i,j) = BadPixelMatrix_double(i,j) + abs(OriginalImage_G(i,j) -  ProtanopesImage_G(i,j));
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