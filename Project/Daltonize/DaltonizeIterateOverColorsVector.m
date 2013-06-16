function [ Ifinal , fileinfo , folderInfo ] = DaltonizeIterateOverColorsVector( OriginalPic_RGB )

%% Initializing stage

close all
%daltonize for p (modifying errors)
M = [-1 0 0; 
      1 1 0; 
      1 0 1];
  
%Choose between two mods of searching :
%  1 - Going from a matrix which converts reds to white , to a matrix which converts reds to blue
% -1 - Going from a matrix which converts reds to blue , to a matrix which converts red to white
MSearchingMode = 1;

%The amount of changing of M in each iteration
ModificationConst = 0.05;

%if we are in the seecond mod - update the matrix
if(MSearchingMode == -1)
    M(2,1) = M(2,1) - 10 * ModificationConst;
    M(3,1) = M(3,1) + 10 * ModificationConst;
end

%Initialize the SimilarPixes flag
ThereAreSimilarPixels = true;

%Initialize the edge size of the similarity Checker
InitialEdgeSize = 21;

%The max size of iterations for one edge
MaxEdgeIterations = 10;

%Initialize an iterations counter
iterations = 1;

%Display Figures for debuging
dispFig = 0;

originalImage = double(OriginalPic_RGB);
reshapedImage = reshape(originalImage,size(originalImage,1)*size(originalImage,2),size(originalImage,3));

%Create colors vector - consisting all colors in the pictures with a
%distance greater the the initial EdgeSize
cluster_centers = CreateColorsVector(originalImage , InitialEdgeSize);
cluster_centers = reshape(cluster_centers,[size(cluster_centers,1) 1 3]);

%Simulating what protanopes people see for the centers list
simulated_centers = protanopes(cluster_centers);

%% Classify each color from cluster centers, as belonging to Ccorrect or Cincorrect

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
DichI3 = protanopes(Cincorrect);

%calculate errors between two RGB values
errorp = abs(Cincorrect - double(DichI3));

%% Start of iterations until a good reult will be found for the incorrect colors

EdgeSize = InitialEdgeSize;
err2mod = M;

while (ThereAreSimilarPixels)
    
    %To avoid an infinity loop - we reducing the EdgeSize every X iterations
    if( mod(iterations , MaxEdgeIterations)==0 && EdgeSize > 3)
        
        EdgeSize = EdgeSize -2;
        err2mod = M;
        
    end
    
    %Run daltonize function on the image that needs daltonize (I3)
    Cdalton = RecoloreUsingErrorModification(Cincorrect ,errorp, err2mod);

    %Simulating what protanopes people see
    Cprotanope = protanopes(Cdalton);
    
    %find similar pixels
    ThereAreSimilarPixels = RGBSimilarityChecker(reshape(Cprotanope,size(Cprotanope,1)*size(Cprotanope,2),size(Cprotanope,3)) , IcorrectColors , EdgeSize);
    
    %Keep counting iterations
    iterations = iterations + 1;
    
    % change the err2mod , maintaining image energy 
    err2mod(2,1) = err2mod(2,1) -  MSearchingMode * ModificationConst;
    err2mod(3,1) = err2mod(3,1) +  MSearchingMode * ModificationConst;
      
    disp(strcat('---- iteration- ',num2str(iterations-1),'---EdgeSize- ',num2str(EdgeSize),' ---- '));    
end

%% Produce the result image - replace in the original image, every color in Cincorrect with the corresponding color in Cdalton
    
%Daltonize the image using the correction matrix that we found
Ifinal = DaltonizeImageUsingChosenErrorModificationMatrix(OriginalPic_RGB,err2mod);
if (dispFig), figure('Name','Ifinal');imshow(uint8(Ifinal)); end

%% Produce the file path 

%return the name info about the reult
folderInfo = ['DalIterOverColorsVec - Searching Mode ' ,num2str(MSearchingMode) ,' InitialEdgeSize ',num2str(InitialEdgeSize),' ModificationConst ',num2str(ModificationConst)];
fileinfo = ['iter',num2str(iterations),'edge',num2str(EdgeSize)];
end