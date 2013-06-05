%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [  ] = Q4(  )
% Q4 - Determine illumination of a scene in a given image using linear model of illuminants

%Create a test images array
images = ['macbethUnderIllumX.jpg' ;  'macbethUnderIllumY.jpg'];

%iterate over all the images
for i=1:size(images,1)
    
    %Load the test image
    img = imread(images(i,:));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Determine illumination of a scene using linear model of illuminants
    
    Illuminant = DetermineIlluminationUsingLinearModel(img);
    Illuminant = Illuminant(:,1);
    
    %Normalize the illuminant
    NormalizedIlluminant = NormalizeIlluminants(Illuminant);
    
    %Plot illuminant
    figure('Name',[ images(i,:) , ' Illuminant']);
    plot(NormalizedIlluminant);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Determine which of the CIE illuminants is the closest to the one we found
    
    %load the illuminants 
    load('CIEilluminants.mat');
    
    %Create an illuminants array
    illum = [CIE_A CIE_B CIE_C CIE_D50 CIE_D55 CIE_D65 CIE_D75 ...
                CIE_FL2 CIE_FL7];
            
    %Normalize all the illuminants in illum
    illum = NormalizeIlluminants(illum);
    
    %Duplicate the found illuminant vector
    NormalizedIlluminant = repmat(NormalizedIlluminant,[1 size(illum,2)]); 
    
    %Calculating the MSE for each illuminant 
    MSEResults = sum((NormalizedIlluminant-illum).^2);
    
    %Getting the min index
    [~,index] = min(MSEResults);
    
    %Plot the closest illuminant
    hold all;
    plot(illum(:,index));
    
end

end





