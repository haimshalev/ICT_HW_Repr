function [ FoundSimilarity ] = RGBSimilarityChecker( I5Colors , IcorrectColors , EdgeSize )
    
    %For each color check if it exist in the correctColorsVector
    for i=1:size(I5Colors,1)
        %Only if the color isn't black
        if (sum(I5Colors(i,:) ~= [0 0 0]) ~= 0)
            %Check if the color exist in the correct colors
           for j=1:size(IcorrectColors,1)
               Difference = abs( double(I5Colors(i,:)) - double(IcorrectColors(j,:)) );
               if max(Difference(:)) < EdgeSize
                    FoundSimilarity = true;
                    return;
                end
           end
        end
    end
    FoundSimilarity = false;
end


