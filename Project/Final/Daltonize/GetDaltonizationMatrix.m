function [ M ] = GetDaltonizationMatrix( ColorBlindType )
    %# ColorBlindType = 1  for protanopes
    %# ColorBlindType = 2  for deuteranopes
    %# ColorBlindType = 3  for tritanopic

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

