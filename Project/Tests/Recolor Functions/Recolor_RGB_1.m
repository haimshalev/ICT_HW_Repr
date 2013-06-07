function [ FixedPic_RGB ] = Recolor_RGB_1(OriginalPic_RGB)

redChannel = OriginalPic_RGB(:,:,1);
greenChannel = OriginalPic_RGB(:,:,2);
blueChannel = OriginalPic_RGB(:,:,3);

newRed = blueChannel;
newGreen = greenChannel;
newBlue = redChannel;

FixedPic_RGB = cat(3, newRed, newGreen, newBlue);

%% TODO 
% source code:   http://www.mathworks.com/matlabcentral/answers/11256
%thresholdValue = 5; 
%greenishPixels = (single(greenChannel) - 0.5*(single(redChannel) + single(blueChannel))) > thresholdValue;
%newRed = 255-greenChannel;
%newRed(greenishPixels) = 255;
%newGreen = 255-greenChannel;
%newGreen(greenishPixels) = 0;
%newBlue = 255-blueChannel;
%newBlue(greenishPixels) = 0;
%rgbImage2 = cat(3, newRed, newGreen, newBlue);

end