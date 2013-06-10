%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [  ] = Q6(  )
    img = imread('macbethUnderIllumX.jpg');

    % linear model (Q4)
    LinIllum = DetermineIlluminationUsingLinearModel(img);
    LinIllum = LinIllum(:,1);
    rgbValues = FindSurface(img, LinIllum);
    figure('Name','macbeth surface Determined by linear model illuminant Q4');
    display_colors(rgbValues);
    
    % gray world assumption (Q5)
    GrayAssumpIllum = DetermineIlluminationUsingGrayWorldAssumption(img);
    rgbValues = FindSurface(img, GrayAssumpIllum);
    figure('Name','macbeth surface Determined by gray world assumption illuminant Q5');
    display_colors(rgbValues);
   
    %Display the macbeth surface
    load('macbeth.mat');
    rgbValues = GetRGBValues(macbeth);    
    figure('Name','Macbeth surface');
    display_colors(rgbValues);
    
    disp('linear model illuminant (Q4) gives better surface results!');
    disp('we used the gray world ASSUMPTION, this assumption can be wrong, the mean might not be gray... ');
end


function [ rgbValues ] = FindSurface(img , Illum) 
    % normalization
    Normalized_Illum = NormalizeIlluminants(Illum);

    % Find the Basis functions
    load('macbeth.mat');
    basisFunctions = FindBasisFunctions(macbeth);
    basisFunctions = basisFunctions(:,1:3);

    % Assume sensors are given in kodakFilters.mat
    load('KodakFilters.mat');

    Ls = kodakFilters' * diag(Normalized_Illum) * basisFunctions;


    [SizeX,SizeY,~] = size(img);
    Surfaces = zeros(3,24);
    Surface_Iterator = 1;
    for i=1:SizeX
            for j=1:SizeY
                Pixel = reshape(img(i, j, :), 3, 1);
                Surfaces(:,Surface_Iterator) = Ls\double(Pixel);
                Surface_Iterator = Surface_Iterator+1;
            end
    end

    rgbValues = GetRGBValues(basisFunctions*Surfaces);
   
end
