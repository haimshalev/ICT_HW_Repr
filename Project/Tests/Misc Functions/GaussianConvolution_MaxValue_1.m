function [ ReturnMatrix ] = GaussianConvolution_MaxValue_1(OriginalMatrix)
        % SOS Haim!

        %G = fspecial('gaussian',[9 9],2.5);
        %G(5,5) = 1;
        %G = G * 5;
        
        G = ones(7,7);
        G = G * 0.1;
        G(4,4) = 1;

        
        Ig1= imfilter(OriginalMatrix,G,'same');
        [SizeX,SizeY] = size(Ig1);
        ReturnMatrix = Ig1;
        for i=1:SizeX
            for j=1:SizeY
                if ReturnMatrix(i,j) > 1
                    ReturnMatrix(i,j) = 1;
                end
            end
        end
end

