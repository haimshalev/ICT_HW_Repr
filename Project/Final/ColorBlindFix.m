function [ Ifinal , fileinfo , folderInfo ] = ColorBlindFix( ColorBlindType, OriginalPic_RGB )
%% Summary

%{
    A generic function which gets a color blind type and an image.  
    Returns a daltonize image and debug information about the result:
        ModificationConst,EdgeSize,Iterations...

    Types supported:
        ColorBlindType = 1  for protanopes
        ColorBlindType = 2  for deuteranopes
        ColorBlindType = 3  for tritanopic
%}
 
%% Initializing stage

%daltonize for p (modifying errors)
M = GetDaltonizationMatrix( ColorBlindType );
 
%The amount of changing of M in each iteration
ModificationConst = 0.01;

%The max size of iterations for one edge
MaxEdgeIterations = 50;

%Initialize the SimilarPixes flag
ThereAreSimilarPixels = true;

%Initialize the edge size for CreateColorsVector()
CreateColorsVector_EdgeSize = 19;

%Initialize the edge size of the similarity Checker
InitialEdgeSize = 50;

%Initialize an iterations counter
iterations = 1;

disp(['--- Start daltonizing image with: ModificationConst=' num2str(ModificationConst) ' InitialEdgeSize=' num2str(InitialEdgeSize)]); 

%% Create colors vectors

originalImage = double(OriginalPic_RGB);

%Create colors vector - consisting all colors in the pictures with a
%distance greater the the CreateColorsVector_EdgeSize
cluster_centers = CreateColorsVector(originalImage , CreateColorsVector_EdgeSize);
cluster_centers = reshape(cluster_centers,[size(cluster_centers,1) 1 3]);

%Simulating what protanopes people see for the centers list
simulated_centers = SimulateColorBlindImage(ColorBlindType,cluster_centers);

%% Classify each color from cluster centers, as belonging to Ccorrect or Cincorrect

disp('--- Classify each color from the color vector, as belonging to Ccorrect or Cincorrect');

%calculate errors between two RGB values
E = abs(cluster_centers - double(simulated_centers));
    
%Creating a binary mask  - ones in the places that needs daltonize and
%zeros in the rest
Cand = (E > 55);
Cand = Cand(:,:,1) | Cand(:,:,2) | Cand(:,:,3);
Cand = repmat(Cand , [1 1 3]);

%Finding the colors that needs to daltonized
Cincorrect = cluster_centers .* Cand;

%Finding the colors that don't need daltonize - the complement of I3
Ccorrect = cluster_centers .* ~Cand;

%% Optimizing Performance 

%For better performance we prepere the matrices that will be for all of
%iterations before the while loop

IcorrectColors = reshape(Ccorrect,size(Ccorrect,1)*size(Ccorrect,2),size(Ccorrect,3));

%Simulate the image shown by dichromats
DichI3 = SimulateColorBlindImage(ColorBlindType,Cincorrect);

%calculate errors between two RGB values
errorp = abs(Cincorrect - double(DichI3));

%% Start of iterations until a good transformation matrix will be found

EdgeSize = InitialEdgeSize;
err2mod = M;

disp('--- Start searching transformation matrix');

while (ThereAreSimilarPixels)
    
    %To avoid an infinity loop - we reducing the EdgeSize every X iterations
    if( mod(iterations , MaxEdgeIterations)==0 && EdgeSize > 3)      
        EdgeSize = EdgeSize -2;
        err2mod = M; 
        
        disp(strcat('---- Current iteration: ',num2str(iterations),' EdgeSize: ',num2str(EdgeSize)));
    end

    %Run daltonize function on the image that needs daltonize (I3)
    Cdalton = Daltonize(Cincorrect ,errorp, err2mod);

    %Simulating what protanopes people see
    Cprotanope = SimulateColorBlindImage(ColorBlindType,Cdalton);
    
    %find similar pixels
    ThereAreSimilarPixels = CheckColorIntersection(reshape(Cprotanope,size(Cprotanope,1)*size(Cprotanope,2),size(Cprotanope,3)) , IcorrectColors , EdgeSize);
    
    %Keep counting iterations
    iterations = iterations + 1;
    
    % Adjust Daltonization Matrix according to Color Blind Type 
    err2mod = AdjustDaltonizationMatrix(ColorBlindType,err2mod,ModificationConst);     
end

disp(['--- Transformation matrix found in ' num2str(iterations) ' iterations']);

%% Produce the result image - by daltonizing the image using the founded transformation matrix

disp('--- Produce the result image by daltonizing the image using the founded transformation matrix');

%Daltonize the image using the correction matrix that we found
I2 = SimulateColorBlindImage(ColorBlindType,originalImage);    % Simulating what protanopes people see
E = abs(originalImage - double(I2));                           % calculate errors between two RGB values
Ifinal = uint8( Daltonize(originalImage,E,err2mod) );

%% Produce the file path 

%return the name info about the reult
folderInfo = ['DalIterOverColorsVec_InitialEdgeSize ',num2str(InitialEdgeSize)];
fileinfo = ['_iter',num2str(iterations),'_edge',num2str(EdgeSize),'_NoEnergy'];
end