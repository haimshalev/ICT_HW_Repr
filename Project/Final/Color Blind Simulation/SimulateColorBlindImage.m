function [ SimulatedImage ] = SimulateColorBlindImage( ColorBlindType , RGBImage )
    %# ColorBlindType = 1  for protanopes
    %# ColorBlindType = 2  for deuteranopes
    %# ColorBlindType = 3  for tritanopic

    if ColorBlindType == 1      
        SimulatedImage = protanopes(RGBImage);
    elseif ColorBlindType == 2   
        SimulatedImage = deuteranopes(RGBImage); 
    elseif ColorBlindType == 3   
        SimulatedImage = tritanopic(RGBImage);
    else
        SimulatedImage = 0;
    end
end

