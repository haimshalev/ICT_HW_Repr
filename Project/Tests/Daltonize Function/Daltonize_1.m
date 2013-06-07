function [ FixedPicture ] = Daltonize_1(OriginalPic_RGB,BluePic_RGB)

%# Convert the images to HSV space
OriginalPic_HSV = rgb2hsv(OriginalPic_RGB);    
BluePic_HSV = rgb2hsv(BluePic_RGB);

%# Get the hue plane scaled from 0 to 360
OriginalPic_H = 360.*OriginalPic_HSV(:,:,1);     

%# Select "red" pixels
RedIndex = ~(OriginalPic_H > 35) | ~(OriginalPic_H < 340);

%# Get the original planes
OriginalPic_New_H = OriginalPic_HSV(:,:,1);
OriginalPic_New_S = OriginalPic_HSV(:,:,2);
OriginalPic_New_V = OriginalPic_HSV(:,:,3);

%# Get the blue planes
BluePic_H = BluePic_HSV(:,:,1);
BluePic_S = BluePic_HSV(:,:,2);
BluePic_V = BluePic_HSV(:,:,3);

%# Set the selected pixel saturations to 0
OriginalPic_New_H(RedIndex) = BluePic_H(RedIndex);
OriginalPic_New_S(RedIndex) = BluePic_S(RedIndex);           
OriginalPic_New_V(RedIndex) = BluePic_V(RedIndex); 

%# Update the original pic plane
OriginalPic_HSV(:,:,1) = OriginalPic_New_H;
OriginalPic_HSV(:,:,2) = OriginalPic_New_S;     
%OriginalPic_HSV(:,:,3) = OriginalPic_New_V;

FixedPicture = hsv2rgb(OriginalPic_HSV)*256; 
end