function [ ReturnMatrix ] = GaussianConvolution_MaxValue_1(OriginalMatrix)
        G = fspecial('gaussian',[7 7],0.5);
        G(4,4) = 1;
        G = G * 5;
        
       %{ 
        A = 1;
        B = 0.5;
        C = 0.25;
        D = 0.125;
        
        G = [ D D D D D D D ; ...
              D C C C C C D ; ...
              D C B B B C D ; ...
              D C B A B C D ; ...
              D C B B B C D ; ...
              D C C C C C D ; ...
              D D D D D D D ; ...
            ];
       %} 
        
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

