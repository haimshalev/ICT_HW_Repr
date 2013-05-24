function [ ] = Daltonize_1(OriginalPic_RGB)

BluePic_RGB = RedBlueSwap_RGB_1(OriginalPic_RGB);

%# Convert the image to HSV space
OriginalPic_HSV = rgb2hsv(OriginalPic_RGB);    
BluePic_HSV = rgb2hsv(BluePic_RGB);

%# Get the hue plane scaled from 0 to 360
OriginalPic_H = 360.*OriginalPic_HSV(:,:,1); 
BluePic_H = 360.*BluePic_HSV(:,:,1);     

%# Get the saturation plane
OriginalPic_S = OriginalPic_HSV(:,:,2);
BluePic_S = BluePic_HSV(:,:,2);

%# Select "red" pixels
RedIndex = ~(OriginalPic_H > 35) | ~(OriginalPic_H < 340)

%# Set the selected pixel saturations to 0
OriginalPic_S(RedIndex) = BluePic_S(RedIndex);           

%# Update the saturation plane
OriginalPic_HSV(:,:,2) = OriginalPic_S;         

FixedPicture = hsv2rgb(OriginalPic_HSV); 
figure;imshow(FixedPicture);


[OriginalPic_S_X, OriginalPic_S_Y] = size(OriginalPic_S);
[OriginalPic_H_X, OriginalPic_H_Y] = size(OriginalPic_H);
[RedIndex_X, RedIndex_Y] = size(RedIndex);
[OriginalPic_RGB_X, OriginalPic_RGB_Y] = size(OriginalPic_RGB);
[OriginalPic_HSV_X, OriginalPic_HSV_Y] = size(OriginalPic_HSV);

fprintf('OriginalPic_S:   %d X %d \n',OriginalPic_S_X,OriginalPic_S_Y);
fprintf('OriginalPic_H:   %d X %d \n',OriginalPic_H_X,OriginalPic_H_Y);
fprintf('RedIndex:        %d X %d \n',RedIndex_X,RedIndex_Y);
fprintf('OriginalPic_RGB: %d X %d \n',OriginalPic_RGB_X,OriginalPic_RGB_Y);
fprintf('OriginalPic_HSV: %d X %d \n',OriginalPic_HSV_X,OriginalPic_HSV_Y);



%{
Temp1 = [ 1 1 1 ; 1 1 1 ; 1 8 1 ; 1 1 2 ; 1 1 1 ];
Temp2 = zeros(7,8);
Temp2(Temp1) = 5
%}

end