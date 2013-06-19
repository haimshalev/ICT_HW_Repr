function [colorsVector] = CreateColorsVector(image , MaxDif) 
%% Summary

%{
    Create colors vector - consisting all colors in image with a
    distance greater the the MaxDif
%}  

%% Create Colors
disp(['---- Start creating color vector']);
tic;

%Reshape the image to 2 dimensional
reshapedImageLab = reshape(RGB2Lab(image) , [size(image,1)*size(image,2) size(image,3)]);

%Creating a list of colors
colorsVector = [0 0 0];

% if the current color isn't in our color list , add it
% for each color in image
for i=1:size(reshapedImageLab,1)
    
    % assume color is not in list    
    ColorExist = false;                                                             
    j=1;       
    
    % foreach color in color-list
    while(j<=size(colorsVector,1) && ~ColorExist)    
        
        % difference between image color to color-list color 
        Difference = abs( double(colorsVector(j,:)) - double(reshapedImageLab(i,:)) );  
        
        % if difference smaller then MaxDif then colors are equal
        if sum(Difference(:)) < MaxDif
            ColorExist = true;  
        end
        j = j+1;
    end    
    
    %color dose not exist in colorlist 
    if ~ColorExist 
       
       % add color to color-List
       colorsVector = [reshapedImageLab(i,:) ; colorsVector];    
    end

end

%Remove the zero stimuli
colorsVector(size(colorsVector,1),:) = [];

%Transform the image back to RGB and resize it
colorsVector = Lab2RGB(reshape(colorsVector,[size(colorsVector,1) 1 3]));
colorsVector = double(reshape(colorsVector,[size(colorsVector,1) 3]));

disp(['---- Created a color vector of ' ,num2str(size(colorsVector,1)), ' colors at ' num2str(toc) ' seconds']);

end