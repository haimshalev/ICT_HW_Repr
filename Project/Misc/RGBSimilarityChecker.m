function [ FoundSimilarity ] = RGBSimilarityChecker( I5Colors , IcorrectColors , EdgeSize )
    
    I5Colors = reshape(I5Colors, [size(I5Colors,1) 1 3]);
    IcorrectColors = reshape(IcorrectColors, [size(IcorrectColors,1) 1 3]);

    I5Lab = reshape(RGB2Lab(I5Colors),[size(I5Colors,1) 3]);
    IcorrectLab = reshape(RGB2Lab(IcorrectColors),[size(IcorrectColors,1) 3]);
    
    %For each color check if it exist in the correctColorsVector
    for i=1:size(I5Lab,1)
        %Only if the color isn't black
        if (sum(I5Lab(i,:) ~= [0 0 0]) ~= 0)
            %Check if the color exist in the correct colors
           for j=1:size(IcorrectLab,1)
               Difference = abs( double(I5Lab(i,:)) - double(IcorrectLab(j,:)) );
               if sum(Difference(:)) < EdgeSize
                    FoundSimilarity = true;
                    return;
                end
           end
        end
    end
    FoundSimilarity = false;
end


