function [ Ifinal , fileinfo , folderInfo ] = Daltonize( OriginalPic_RGB )

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
    M(2,1) = M(2,1) - 7 * ModificationConst;
    M(3,1) = M(3,1) + 7 * ModificationConst;
end

%Initialize the SimilarPixes flag
ThereAreSimilarPixels = true;

%Initialize the edge size of the similarity Checker
InitialEdgeSize = 21;

%The max size of iterations for one edge
MaxEdgeIterations = 15;

%Initialize an iterations counter
iterations = 1;

%Display Figures for debuging
dispFig = 0;

%% Algorithm 

I1 = double(OriginalPic_RGB);
if (dispFig), figure('Name','I1');imshow(uint8(I1)); end

%Simulating what protanopes people see
I2 = protanopes(I1);
if (dispFig), figure('Name','I2');imshow(uint8(I2));end

%calculate errors between two RGB values
E = abs(I1 - double(I2));
if (dispFig),figure('Name','E');imshow(uint8(E));end
    
%Creating a binary mask  - ones in the places that needs daltonize and
%zeros in the rest
Iand = (E > 55);
Iand = Iand(:,:,1) | Iand(:,:,2) | Iand(:,:,3);
Iand = repmat(Iand , [1 1 3]);
if (dispFig), figure('Name','Iand');imshow(uint8(Iand*255));end

%Finding the image that needs to daltonized
I3 = I1 .* Iand;
if (dispFig), figure('Name','I3');imshow(uint8(I3));end

%Finding the correct image - the complement of I3
Icorrect = I1 .* ~Iand;
if (dispFig), figure('Name','Icorrect');imshow(uint8(Icorrect));end

%SimulatedIcorrect
simICorrect = protanopes(Icorrect);
if (dispFig), figure('Name','SimulatedIcorredt');imshow(uint8(simICorrect));end


%% Optimizing Performance 

%For better performance we prepere the matrices that will be for all of
%iterations before the while loop

IcorrectColors = CreateColorsVector(Icorrect);

%Simulate the image shown by dichromats
DichI3 = protanopes(I3);

%calculate errors between two RGB values
errorp = abs(I3 - double(DichI3));



%% Start of iterations until a good reult will be found

EdgeSize = InitialEdgeSize;
err2mod = M;

while (ThereAreSimilarPixels)
    
    %To avoid an infinity loop - we reducing the EdgeSize every X iterations
    if( mod(iterations , MaxEdgeIterations)==0 && EdgeSize > 3)
        
        EdgeSize = EdgeSize -2;
        err2mod = M;
        
    end
    
    %Run daltonize function on the image that needs daltonize (I3)
    I4 = RecoloreUsingErrorModification(I3 ,errorp, err2mod);
    if (dispFig), figure('Name','I4');imshow(uint8(I4));end

    %Simulating what protanopes people see
    I5 = protanopes(I4);
    if (dispFig), figure('Name','I5');imshow(uint8(I5));end
    
    %find similar pixels
    ThereAreSimilarPixels = RGBSimilarityChecker(CreateColorsVector(I5) , IcorrectColors , EdgeSize);
    
    %Keep counting iterations
    iterations = iterations + 1;
    
    % change the err2mod , maintaining image energy 
    err2mod(2,1) = err2mod(2,1) -  MSearchingMode * ModificationConst;
    err2mod(3,1) = err2mod(3,1) +  MSearchingMode * ModificationConst;
    
    Ifinal = uint8(Icorrect) + uint8(I4);
    if (dispFig), figure('Name','Ifinal');imshow(uint8(Ifinal));end
    
    %SimulatedIcorrect
    simIfinal = protanopes(Ifinal);
    if (dispFig), figure('Name','SimulatedIFinal');imshow(uint8(simIfinal));end
    
    disp(strcat('-------------- iteration- ',num2str(iterations-1),'---EdgeSize- ',num2str(EdgeSize),' -------------- '));    
end

%% Create the final Image (addding in our case is join because the mask
%created zeroed cells
Ifinal = uint8(Icorrect) + uint8(I4);
if (dispFig), figure('Name','Ifinal');imshow(uint8(Ifinal)); end

%return the name info about the reult
folderInfo = ['Searching Mode ' ,num2str(MSearchingMode) ,' InitialEdgeSize ',num2str(InitialEdgeSize),' ModificationConst ',num2str(ModificationConst)];
fileinfo = ['iter',num2str(iterations),'edge',num2str(EdgeSize)];
end

