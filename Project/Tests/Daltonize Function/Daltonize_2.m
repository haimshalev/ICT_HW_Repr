 function [ FixedPicture_RGB ] = Daltonize_2(OriginalPic_RGB,BluePic_RGB,Threshold)
     FixedPicture_RGB = OriginalPic_RGB;

     %# Get the original planes 
     Fixed_R = FixedPicture_RGB(:,:,1);
     Fixed_G = FixedPicture_RGB(:,:,2);
     Fixed_B = FixedPicture_RGB(:,:,3);

     %# Get the BluePic planes
     Blue_R = BluePic_RGB(:,:,1);
     Blue_G = BluePic_RGB(:,:,2);
     Blue_B = BluePic_RGB(:,:,3);

    %# gert the Projection Distance Matrix
    [~,ProjectionDistanceMatrix]= protanopes(OriginalPic_RGB);

    %# create the Far Pixel matrix - init all pixels to be CLOSE!
    [SizeX,SizeY] = size(ProjectionDistanceMatrix);
    FarPixelsMatrix = false(SizeX,SizeY);

    %# update the far pixels
    for ii=1:SizeX
        for jj=1:SizeY
           if  ProjectionDistanceMatrix(ii,jj) > Threshold 
               FarPixelsMatrix(ii,jj) = true;     %# far pixel
           end
        end
    end

    %# update the far pixels from the blue picture ( all 3 planes )
    Fixed_R(FarPixelsMatrix) = Blue_R(FarPixelsMatrix);
    Fixed_G(FarPixelsMatrix) = Blue_G(FarPixelsMatrix);
    Fixed_B(FarPixelsMatrix) = Blue_B(FarPixelsMatrix);

    %# update return planes with fixed planes
    FixedPicture_RGB(:,:,1) = Fixed_R;
    FixedPicture_RGB(:,:,2) = Fixed_G;
    FixedPicture_RGB(:,:,3) = Fixed_B;
end
