function [ WhiteBlackRedPic ] = RedRecognition_4(OriginalPic_RGB)

hsvImage = rgb2hsv(OriginalPic_RGB);        %# Convert the image to HSV space
hPlane = 360.*hsvImage(:,:,1);              %# Get the hue plane scaled from 0 to 360
sPlane = hsvImage(:,:,2);                   %# Get the saturation plane
nonRedIndex = (hPlane > 35)&(hPlane < 200); %# Select "non-red" pixels
sPlane(nonRedIndex) = 0;                    %# Set the selected pixel saturations to 0
hsvImage(:,:,2) = sPlane;                   %# Update the saturation plane
WhiteBlackRedPic = hsv2rgb(hsvImage);       %# Convert the image back to RGB space

end