function [colorsVector] = CreateColorsVector(image) 
    
    tic;

    %Reshape the image to 2 dimensional
    reshapedImage = reshape(image , [size(image,1)*size(image,2) size(image,3)]);

    %Creating a list of colors
    colorsVector = [0 0 0];

    % if the current color isn't in our color list , add it
    for i=1:size(reshapedImage,1)   %# for each color in image
        ColorExist = false;         %# assume color is not in list                                                        
        j=1;        
        while(j<=size(colorsVector,1) && ~ColorExist)    %# foreach color in color-list
            Difference = abs( double(colorsVector(j,:)) - double(reshapedImage(i,:)) );  %# difference between image color to color-list color 
            if max(Difference(:)) < 21
                ColorExist = true;  %# if difference smaller then 21 then colors are equal
            end
            j = j+1;
        end        
        if ~ColorExist   %# color dose not exist in colorlist 
           colorsVector = [reshapedImage(i,:) ; colorsVector];  %# add color to color-List  
        end
        
    end
    
    colorsVector(size(colorsVector,1),:) = [];
    
    toc;
end