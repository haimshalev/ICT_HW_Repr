function [ New_M ] = AdjustDaltonizationMatrix( ColorBlindType ,M , ModificationConst )
    %# ColorBlindType = 1  for protanopes
    %# ColorBlindType = 2  for deuteranopes
    %# ColorBlindType = 3  for tritanopic
    
    New_M = M;
    if ColorBlindType == 1      
        New_M(2,1) = New_M(2,1) - ModificationConst;
        New_M(3,1) = New_M(3,1) + ModificationConst;
    elseif ColorBlindType == 2   
        New_M(1,2) = New_M(1,2) - ModificationConst;
        New_M(3,2) = New_M(3,2) + ModificationConst; 
    elseif ColorBlindType == 3   
        New_M(2,3) = New_M(2,3) - ModificationConst;
        New_M(1,3) = New_M(1,3) + ModificationConst;
    else
        New_M = 0;
    end
end

