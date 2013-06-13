function [ Ifinal ] = Daltonize( OriginalPic_RGB )

%% Initializing stage

%daltonize for p (modifying errors)
err2mod = [-1 0 0; 1 1 0; 1 0 1];

%Initialize the SimilarPixes flag
ThereAreSimilarPixels = true;

%Initialize the edge size of the similarity Checker
EdgeSize = 21; 

%Initialize an iterations counter
iterations = 1;

%% Algorithm 

I1 = double(OriginalPic_RGB);

%Simulating what protanopes people see
I2 = protanopes(I1);

%calculate errors between two RGB values
E = abs(I1 - double(I2));

%Creating a binary mask  - ones in the places that needs daltonize and
%zeros in the rest
Iand = (E > 0.01 * I1);
Iand = Iand(:,:,1) | Iand(:,:,2) | Iand(:,:,3);
Iand = repmat(Iand , [1 1 3]);

%Finding the image that needs to daltonized
I3 = I1 .* Iand;

%Finding the correct image - the complement of I3
Icorrect = I1 .* ~Iand;

while (ThereAreSimilarPixels)
    
    %To avoid an infinity loop - we reducing the EdgeSize every X iterations
    if( mod(iterations , 20)==0 && EdgeSize > 3)
        EdgeSize = EdgeSize -2;
    end
    
    %Run daltonize function on the image that needs daltonize (I3)
    I4 = RecoloreUsingErrorModification(I3 , err2mod);

    %Simulating what protanopes people see
    I5 = protanopes(I4);
    
    %find similar pixels
    ThereAreSimilarPixels = RGBSimilarityChecker(I5 , Icorrect , EdgeSize);
    
    %Keep counting iterations
    iterations = iterations + 1;
    
    Disp(['SimilarityChecker found ' ThereAreSimilarPixels 'similar']);
    
end

%Create the final Image (addding in our case is join because the mask
%created zeroed cells
Ifinal = Icorrect + I4;

end

