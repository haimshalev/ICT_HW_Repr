function [ M ] = GetDaltonizationMatrix( ColorBlindType )
%% Summary

%{
    Get the initial error transformation matrix accordingly to the dichromat type

    Input: ColorBlindType - 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
    Output: M - The initial transformation matrix for the specified type of dichromat(As shown in the project documentation)

%}
 
%% Returning the matrices

    if ColorBlindType == 1       %# protanopes: Red Energy =  0
        M = [ 0 0 0 ;               
             .7 1 0 ; 
             .7 0 1 ];
    elseif ColorBlindType == 2   %# deuteranopes: Green Energy 0
        M = [ 1 .7 0 ; 
              0  0 0 ; 
              0 .7 1 ];    
    elseif ColorBlindType == 3   %# tritanopic: Blue Energy 0
        M = [ 1 0 .7 ; 
              0 1 .7 ; 
              0 0  0 ];
    else
        M = 0;
    end
end

