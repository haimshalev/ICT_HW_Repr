function [ FixedPicture ] = Daltonize_1(OriginalPic_RGB,BluePic_RGB,LowerThreshold)

    %# Convert the images to HSV space
    OriginalPic_HSV = rgb2hsv(OriginalPic_RGB);    
    BluePic_HSV = rgb2hsv(BluePic_RGB);

    %# Get the hue plane scaled from 0 to 360
    OriginalPic_H = 360.*OriginalPic_HSV(:,:,1);     

    %# Select "red" pixels
    RedIndex = ~(OriginalPic_H > LowerThreshold) | ~(OriginalPic_H < 340);

    %# Get the original planes
    New_H = OriginalPic_HSV(:,:,1);
    New_S = OriginalPic_HSV(:,:,2);
    New_V = OriginalPic_HSV(:,:,3);

    %# Get the blue planes
    BluePic_H = BluePic_HSV(:,:,1);
    BluePic_S = BluePic_HSV(:,:,2);
    BluePic_V = BluePic_HSV(:,:,3);

    %# update the Red pixels in New planes from the blue picture
    New_H(RedIndex) = BluePic_H(RedIndex);
    New_S(RedIndex) = BluePic_S(RedIndex);           
    New_V(RedIndex) = BluePic_V(RedIndex); 

    %# Update the original pic plane
    OriginalPic_HSV(:,:,1) = New_H;
    OriginalPic_HSV(:,:,2) = New_S;     
    %OriginalPic_HSV(:,:,3) = OriginalPic_New_V;

    FixedPicture = hsv2rgb(OriginalPic_HSV)*256; 
end