function [colorsVector] = CreateColorsVector(image , MaxDif) 
    
    tic;
    
    %Reshape the image to 2 dimensional
    reshapedImageLab = reshape(RGB2Lab(image) , [size(image,1)*size(image,2) size(image,3)]);

    %Creating a list of colors
    colorsVector = [0 0 0];

    % if the current color isn't in our color list , add it
    for i=1:size(reshapedImageLab,1)   %# for each color in image
        ColorExist = false;         %# assume color is not in list                                                        
        j=1;        
        while(j<=size(colorsVector,1) && ~ColorExist)    %# foreach color in color-list
            Difference = abs( double(colorsVector(j,:)) - double(reshapedImageLab(i,:)) );  %# difference between image color to color-list color 
            if sum(Difference(:)) < MaxDif
                ColorExist = true;  %# if difference smaller then MaxDif then colors are equal
            end
            j = j+1;
        end        
        if ~ColorExist   %# color dose not exist in colorlist 
           colorsVector = [reshapedImageLab(i,:) ; colorsVector];  %# add color to color-List  
        end
        
    end
    
    colorsVector(size(colorsVector,1),:) = [];
    colorsVector = Lab2RGB(reshape(colorsVector,[size(colorsVector,1) 1 3]));
    colorsVector = double(reshape(colorsVector,[size(colorsVector,1) 3]));
    
    disp(['Create a color vector of ' ,num2str(size(colorsVector,1)), ' colors']);
    
    toc;
end