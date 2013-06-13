 function [ FixedPicture_RGB ] = Daltonize_5(OriginalPic_RGB,BluePic_RGB,Threshold)     
    BadPixelMatrix = BadPixelsRecognition2(OriginalPic_RGB,Threshold);
    
    FixedPicture_RGB = OriginalPic_RGB;

    %# Get the original planes 
    New_R = FixedPicture_RGB(:,:,1);
    New_G = FixedPicture_RGB(:,:,2);
    New_B = FixedPicture_RGB(:,:,3);

    %# Get the BluePic planes
    Blue_R = BluePic_RGB(:,:,1);
    Blue_G = BluePic_RGB(:,:,2);
    Blue_B = BluePic_RGB(:,:,3);

    %# update the far pixels from the blue picture ( all 3 planes )
    New_R(BadPixelMatrix) = Blue_R(BadPixelMatrix);
    New_G(BadPixelMatrix) = Blue_G(BadPixelMatrix);
    New_B(BadPixelMatrix) = Blue_B(BadPixelMatrix);

    %# update return planes with fixed planes
    FixedPicture_RGB(:,:,1) = New_R;
    FixedPicture_RGB(:,:,2) = New_G;
    FixedPicture_RGB(:,:,3) = New_B;
end
