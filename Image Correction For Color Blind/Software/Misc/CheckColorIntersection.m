function [ FoundSimilarity ] = CheckColorIntersection( Colors1 , Colors2 , EdgeSize )
%% Summary

%{
    Check if there is no color in I5Colors that is close to color in IcorrectColors.
	We say that a color in near to other color if the LAB distance between them is lower than the EdgeSize param.

	Input: I5Colors - A 3-dimensional matrix representing the RGB values of a group of colors
	       IcorrectColors - A 3-dimensional matrix representing the RGB values of another group of colors
	       EdgeSize - The allowe LAB distance between two tested colors
	Output: If there is a near color FoundSimilarity = true 
				    else FoundSimilarity = false
%} 

%% Check For Color Intersection

    %Prepere the colors vectors
    Colors1 = reshape(Colors1, [size(Colors1,1) 1 3]);
    Colors2 = reshape(Colors2, [size(Colors2,1) 1 3]);

    %Convert the colors vectors from RGB to LAB
    I5Lab = reshape(RGB2Lab(Colors1),[size(Colors1,1) 3]);
    IcorrectLab = reshape(RGB2Lab(Colors2),[size(Colors2,1) 3]);
    
    %For each color check if it close to color in correctColorsVector
    for i=1:size(I5Lab,1)
        
        %Only if the color isn't black
        if (sum(I5Lab(i,:) ~= [0 0 0]) ~= 0)
            
            %Check if the color close to a color in the correct colors
           for j=1:size(IcorrectLab,1)
               
               Difference = abs( double(I5Lab(i,:)) - double(IcorrectLab(j,:)) );
               
               %if the difference is lower the EdgeSize , we found a close
               %color
               if sum(Difference(:)) < EdgeSize
                   
                    FoundSimilarity = true;
                    
                    return;
                    
               end
                
           end
           
        end
        
    end
    
    %if we didn't found a close color return false
    FoundSimilarity = false;
end


