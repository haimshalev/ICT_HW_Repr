function [ New_M ] = AdjustDaltonizationMatrix( ColorBlindType ,M , ModificationConst )
%% Summary

%{
    Adjust the error transformation matrix accordingly to the
    dichromat type

    Types supported:
        ColorBlindType = 1  for protanopes
        ColorBlindType = 2  for deuteranopes
        ColorBlindType = 3  for tritanopic
%}
    
%% Adjust the error transformation matrix 

    New_M = M;
    
    %if the type is protanopes
    if ColorBlindType == 1    
        
        %On every iteration we increase the amount of blue and decrease the
        %amount of green
        New_M(2,1) = New_M(2,1) - ModificationConst;
        New_M(3,1) = New_M(3,1) + ModificationConst;
        
    %if the type is deuteranopes
    elseif ColorBlindType == 2  
        
        %On every iteration we increase the amount of blue and decrease the
        %amount of red
        New_M(1,2) = New_M(1,2) - ModificationConst;
        New_M(3,2) = New_M(3,2) + ModificationConst; 
        
    %if the type is tritanopic
    elseif ColorBlindType == 3
        
        %On every iteration we increase the amount red and decrease the
        %amount of green
        New_M(2,3) = New_M(2,3) - ModificationConst;
        New_M(1,3) = New_M(1,3) + ModificationConst;
    else
        New_M = 0;
    end
end

