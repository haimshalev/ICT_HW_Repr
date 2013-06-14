function [ FoundSimilarity ] = RGBSimilarityChecker( I5 , IcorrectColors , EdgeSize )
    
    I5Colors = CreateColorsVector(I5);
    
    %For each color check if it exist in the correctColorsVector
    for i=1:size(I5Colors,1)
       for j=1:size(IcorrectColors,1)
           Difference = abs( double(I5Colors(i,:)) - double(IcorrectColors(j,:)) );
           if max(Difference(:)) < EdgeSize
                FoundSimilarity = true;
                return;
            end
       end
    end
    FoundSimilarity = false;
end


