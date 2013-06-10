function [ FixedPicture ] = Daltonize_3(OriginalPic_RGB,BluePic_RGB,LowerThreshold)

    %# Convert the images to HSV space
    OriginalPic_HSV = rgb2hsv(OriginalPic_RGB);    

    %# Get the hue plane scaled from 0 to 360
    OriginalPic_H = 360.*OriginalPic_HSV(:,:,1);     

    %# Select "red" pixels
    RedIndex = ~(OriginalPic_H > LowerThreshold) | ~(OriginalPic_H < 340);
    
    RedIndex = double(RedIndex);
    RedIndex = GaussianConvolution_MaxValue_1(RedIndex);

    %# Get the original planes
    OriginalPic_R = OriginalPic_RGB(:,:,1);
    OriginalPic_G = OriginalPic_RGB(:,:,2);
    OriginalPic_B = OriginalPic_RGB(:,:,3);

    %# Get the blue planes
    BluePic_R = BluePic_RGB(:,:,1);
    BluePic_G = BluePic_RGB(:,:,2);
    BluePic_B = BluePic_RGB(:,:,3);

    [SizeX,SizeY] = size(OriginalPic_R);
    for x=1:SizeX
        for y=1:SizeY
            New_R(x,y) = ( RedIndex(x,y)*BluePic_R(x,y) ) + ( (1-RedIndex(x,y))*OriginalPic_R(x,y) );
            New_G(x,y) = ( RedIndex(x,y)*BluePic_G(x,y) ) + ( (1-RedIndex(x,y))*OriginalPic_G(x,y) );
            New_B(x,y) = ( RedIndex(x,y)*BluePic_B(x,y) ) + ( (1-RedIndex(x,y))*OriginalPic_B(x,y) );
        end
    end
    
    
    %# Update the original pic plane
    FixedPicture(:,:,1) = New_R;
    FixedPicture(:,:,2) = New_G;     
    FixedPicture(:,:,3) = New_B;

end