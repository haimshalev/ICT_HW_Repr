function [ FoundSimilarity ] = RGBSimilarityChecker( I5 , Icorrect , EdgeSize )

I5Colors = CreateColorsVector(I5);
IcorrectColors = CreateColorsVector(Icorrect);

%For each color check if it exist in the correctColorsVector
for i=1:size(I5Colors,1)
    
    %if the current color isn't in our color list , add it
    if (~ismember(IcorrectColors, I5Colors(i,:),'rows'))
        FoundSimilarity = 1;
        return;
    end 
end

FoundSimilarity = 0;


end

function [colorsVector] = CreateColorsVector(image)

%Reshape the image to 2 dimensional
reshapedImage = reshape(image , [size(image,1)*size(image,2) size(image,3)]);

%Creating a list of colors
colorsVector = [0 0 0];

for i=1:size(reshapedImage,1)    
    
        %if the current color isn't in our color list , add it
        if (~ismember(colorsVector, reshapedImage(i,:),'rows'))
            colorsVector = [colorsVector ; reshapedImage(i,:)];
        end 
end
end
